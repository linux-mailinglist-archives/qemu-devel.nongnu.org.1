Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8157F6C77
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Pxv-00084K-HL; Fri, 24 Nov 2023 01:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Pxr-00081v-17; Fri, 24 Nov 2023 01:46:59 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Pxo-0007XS-LX; Fri, 24 Nov 2023 01:46:58 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5bd306f86a8so1131283a12.0; 
 Thu, 23 Nov 2023 22:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700808410; x=1701413210; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6AV8oDzMApOcnToDkSYcT6uTvmXO4BrbXwB9MTLkOw=;
 b=CYIq7Mm/04t8nf0aANUYA6j9CfCX+e6nx+ekwyReoXUK91APK3V5AzlP2d7fiYbuef
 Wjn7B6vd6KzVUCKF5v57kwitoGId4kxtHRA4r36grPdAXnwf/V+fI2tCpjDAttx+MnLv
 A8AmbdTyqQH/NQ1/x+UhS8jBnW9Mz/0Bc18QjNSSsVLsnotzFvBNAXlHXN6Ttn6cejK8
 uWsZzyR5QSfgilG0FxhL7999Y2U78JehmFy02vfUM9taAGS2KDf/uwH3ya3gDekudLo9
 9KbW5G6iGm3wOR3xKmdq2edtkBDWHoFXu8tdz6FdQrEFpnFU86Q9kusrGxSgxkCdb6YT
 qffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700808410; x=1701413210;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S6AV8oDzMApOcnToDkSYcT6uTvmXO4BrbXwB9MTLkOw=;
 b=ETIPxbWsHM+QmvUI3fuXBoDI3lbipnM6HNGOZSaLKNz0H3lvf0pexeDAdmae74zpSM
 BqTtlDvczrburSikhg540aL7NbPbxJNkbSNAUJKKNKc/CT2hpZziHNubVC6DlVIhiUgA
 cZsKBJodQYNI+kOmHI6q2sWIM2GKt+Rem0Fwhqb+KAVwjbQ05+Z428Amp2dDGfUgwf9B
 nKH0o+VxAxZ0Uro5vpHO8HkLihfSTHPMQbTwgZ5YV4fpn0jEkKx+QRjB6uSGRBZSBLVX
 pL4aCdFvXm9lcOGePx5vCDrl99UoN2KldvSKaPapp/DfqmrE+v3LcvlrQSypc8QiiJIM
 WpRg==
X-Gm-Message-State: AOJu0YzuUIRUoe9XYiNAanzfnjSOOVYt1aZn3c7X/6Xs8ZqUPkbIXG++
 DwdhwpKgm/I4YVxDYKGRLzg=
X-Google-Smtp-Source: AGHT+IGLgxn+j1PFBkn3IkPJnrk1WuEXaHr3UYjK10unh4i2rqIJTMdPYjw4EJochBRvheq3STdAbg==
X-Received: by 2002:a05:6a20:e616:b0:187:8bd4:e1ba with SMTP id
 my22-20020a056a20e61600b001878bd4e1bamr2399434pzb.37.1700808410100; 
 Thu, 23 Nov 2023 22:46:50 -0800 (PST)
Received: from localhost ([1.145.239.154]) by smtp.gmail.com with ESMTPSA id
 i1-20020a170902c28100b001b86dd825e7sm2437796pld.108.2023.11.23.22.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 22:46:49 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 16:46:32 +1000
Message-Id: <CX6U98UX0CIJ.10PSIK6M2ATZH@wheely>
Subject: Re: [PATCH v2 4/7] pnv/chiptod: Add POWER9/10 chiptod model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231124064001.198572-1-npiggin@gmail.com>
 <20231124064001.198572-5-npiggin@gmail.com>
In-Reply-To: <20231124064001.198572-5-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri Nov 24, 2023 at 4:39 PM AEST, Nicholas Piggin wrote:
> The ChipTOD (for Time-Of-Day) is a chip pervasive facility that keeps a
> time of day clock, and can synchronise that clock to other chips, and
> can synchronize that clock to the timebase facility in each core.
>
> This model implements basic status and error registers, and XXX

Ooops ^^ I'll fix up this changelog next time.

Thanks,
Nick

