Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EEE7362FC
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 07:07:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBTaX-0003yQ-3t; Tue, 20 Jun 2023 01:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBTaU-0003y0-Fg; Tue, 20 Jun 2023 01:07:31 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBTaS-0002LN-TF; Tue, 20 Jun 2023 01:07:30 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-553ad54d3c6so884913a12.1; 
 Mon, 19 Jun 2023 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687237647; x=1689829647;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=av8d+meRDMEmw+rUNFiLEmIhDWBKBTS+5SGeN4eqETI=;
 b=lGWwYe/I+0SgNrDO4Glgn55u/clt+FLJOPqVmkhULGFs9dl5theVzM8liFPPCR19a7
 3ZEPvtW45nwfuVQSD3h1rqWunQmUYxLf8+R4AiOQlLQ1PUeIu/femzLYhEKreSAikLPE
 RU4S+HDgqxv1e8m7FtnxvLgS5NQdh+ErSfoKLO8g/8A7sERUC05NTJ7dXRYQWBXuRlQm
 8O8OEubzHv5SQ0LLRsikVqNdbHZlWDq61EstckDAB03DkiYzcujL2U/KGu3Y4vYwjXxA
 yl+aXDDVIwpHp3YRvJk5DYW8kFXpuYyD70vZBE4y1v+K4bZbmlzIUwwfzd6eg5uv7dMD
 96nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687237647; x=1689829647;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=av8d+meRDMEmw+rUNFiLEmIhDWBKBTS+5SGeN4eqETI=;
 b=RcSUw8tXdsVML4PWveUvfWx4ke/T6lDtBX4sYFm5J3Lb8Jg7yq6G8+Mhao5x+kOWyx
 vfN2QMBOrQrtVIvWEbHif57dgWKt0lgZidhaRbhJfa5ge9cXpkegDjJ7PzC4KKaYxXWV
 /mNPMH38Gtyka6Nfd/rdB2MGHKo/gwMUm+wckcx4I1OAvDjNTn8mpWmxG6O6fGfP2mxt
 Gz6fd2K1ao/XOcdd0GsqPsZhWcJEVw5E6KBN3LZW46FaihOizk4yenS/xLGCVm9yGTr+
 q/VGktvipm+T4jDPSd+W3nrrxgptjQ+v/AdNqnuKrAWizgX0PYVucf+yLlBlC0wNyzQF
 I7Gw==
X-Gm-Message-State: AC+VfDxgeMT0ydvUmThJFTUKFAa2YiZUX8P/bTh3izvVRzOkpCcGahUf
 RH800+IAdwokrQT+Kbsrtj4=
X-Google-Smtp-Source: ACHHUZ5JWRVTtBY88B13oA+gZA5omyPJwfsmk/gSJ9L4rgDAunNfeXdZo3L7psbvvnlyVRHQjqHAbA==
X-Received: by 2002:a05:6a20:8f19:b0:121:8c15:8c04 with SMTP id
 b25-20020a056a208f1900b001218c158c04mr3693430pzk.27.1687237646791; 
 Mon, 19 Jun 2023 22:07:26 -0700 (PDT)
Received: from localhost ([1.146.127.111]) by smtp.gmail.com with ESMTPSA id
 s15-20020a62e70f000000b0066884d4efdbsm490029pfh.12.2023.06.19.22.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 22:07:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 15:07:20 +1000
Message-Id: <CTH7TRQ8I0SP.30Z12X2RSO5JI@wheely>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v3 12/14] target/ppc: Clean up ifdefs in excp_helper.c,
 part 1
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <178a7e99a1d930b8f988280741147513a726a68b.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <178a7e99a1d930b8f988280741147513a726a68b.1686868895.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
> Use #ifdef, #ifndef for brevity and add comments to #endif that are
> more than a few lines apart for clarity.

These will collide with the SOFTMMU ifdef changes that Philippe is
working on I think? They seem okay but maybe wait until after those
are merged?

Thanks,
Nick


