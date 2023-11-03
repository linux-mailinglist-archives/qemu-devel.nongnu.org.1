Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2187E05BF
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:49:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywP9-00057S-LR; Fri, 03 Nov 2023 11:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qywP7-00057D-W7
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:48:14 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qywP6-0000mD-H0
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:48:13 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-581e5a9413bso1159393eaf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699026491; x=1699631291; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Aw64VfmoFgT8Qau7yDbz9lb1DPvHg++RpQrP5oPGOo=;
 b=hNzvvl9NfK7I42kcQiIYmKnPiN27anOFO26GwDglLoHUfp8VoJxB+t/MrDPSOaYsvb
 Q9D4zK0Xoe1DovBeJzctsDPG3eyhlf7kafxD8BfXdfR/vPZmoMWAL3JQzmnW9OHdN6ep
 HEpZQlgKb4sjllphxcF4wccOXQW82QHFI+4AA2VDwLBrQmBZKqRUjANoOAWc4djHP8NR
 VgZ97vQIzQ39gRWHYQxmfOi8rGcv8rqJmmnNPWHgggV0Z0Wy1jMQZXbQT8kRZn6Ka78H
 mAZN5mejpizp41Hf7/7qpUJ4le7IvrwfDJwxuWWbhBee3+AtVgA3pSBgdclzL5hLE8eb
 adGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699026491; x=1699631291;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Aw64VfmoFgT8Qau7yDbz9lb1DPvHg++RpQrP5oPGOo=;
 b=QjZDvUn72QiSemLM6MmMyL0mXnvjlyrxX2UJ2aiwWOGtKfxlhTz+kCTd+KNJCaisrg
 ycICqJV36SJtTRZ/mOKfcRvR1IwpHw2Z4QqEVFvAqenkZaJ/d+ha3IJtSqZF65lDSfZo
 I/DKQa/MaOlu3cvhJPoKOHq7V7NSsPJ4jEGMdan9KIE1lDNf3WGlgQkUqQg5lzsS5W1L
 of+SHqb05jiF9LuOvQ4GmZK01IXme+VjrRBnXFNXNYauvTNV0MfVz5yN3dF5eMScdH4S
 9jHjDteku/KARkfEkbaSrWNGETVYAVrPInC6VNJZ7oLQfzlOLyM+vJ+ZjWu7HiQg7i2u
 EiSg==
X-Gm-Message-State: AOJu0Yw5EgSjxusH03DHNDOCqIbi9N1lnpotN7+Qh/UXaGtsdhqRRjnX
 WK6BZg+1z9dNnmuhNVkxUps=
X-Google-Smtp-Source: AGHT+IHtDNgGoYDHC+i/bp4JCMlFHf1K+KvFYKztfI92w1l8Ts6ZKRFO3hdHa7RD+FvMinACgNtUQQ==
X-Received: by 2002:a4a:e1af:0:b0:57b:6451:8c64 with SMTP id
 15-20020a4ae1af000000b0057b64518c64mr19445275ooy.9.1699026491001; 
 Fri, 03 Nov 2023 08:48:11 -0700 (PDT)
Received: from DESKTOPUU50BPD
 (2603-8080-1f00-9c00-2639-f689-1715-fc7b.res6.spectrum.com.
 [2603:8080:1f00:9c00:2639:f689:1715:fc7b])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a4aaa4c000000b0058737149513sm345149oom.24.2023.11.03.08.48.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 03 Nov 2023 08:48:10 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>
Cc: <qemu-devel@nongnu.org>
References: <20231102201006.33143-1-ltaylorsimpson@gmail.com>
 <7ko7g6b3i7unmncyhql2nlxkjzjtrjdggmcyg55sbxsvven7ad@awzjrozwrgmh>
In-Reply-To: <7ko7g6b3i7unmncyhql2nlxkjzjtrjdggmcyg55sbxsvven7ad@awzjrozwrgmh>
Subject: RE: [PATCH 0/3] Hexagon (target/hexagon) Enable more short-circuit
 packets
Date: Fri, 3 Nov 2023 10:48:09 -0500
Message-ID: <09d101da0e6d$25916280$70b42780$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEk06uHfN3a0MtaXrzDSZkamrufLgHaIVnNscRhwhA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc30.google.com
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

Looks like a problem with git send-email =E2=98=B9

I will troubleshoot ...


> -----Original Message-----
> From: Anton Johansson <anjo@rev.ng>
> Sent: Thursday, November 2, 2023 6:44 PM
> To: Taylor Simpson <ltaylorsimpson@gmail.com>
> Cc: qemu-devel@nongnu.org
> Subject: Re: [PATCH 0/3] Hexagon (target/hexagon) Enable more short-
> circuit packets
>=20
> Hi, Taylor!:) Always nice to see your name pop up here. The patches =
seem to
> have been sent as attachments for whatever reason.
>=20
> / Anton


