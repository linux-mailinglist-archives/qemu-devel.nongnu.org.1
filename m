Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F69FF6A6
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Jan 2025 08:45:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTFsF-0003oD-Tl; Thu, 02 Jan 2025 02:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTFsC-0003nn-EP
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTFsA-0007RC-4Z
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735803839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I2vQN1wzPnw5ph8G5snpj7cU/03MkaA5m52ofg5pvDs=;
 b=D43/43K1xjpd8RhrSmqqrvslD+cNpJTU9FESEEaxBFGHMS3adUDwgh+KdvMGb0AuOIA/Uw
 JBmRXl0bYioGvFFBrXN3SrKQ7Ou17VTqwsPbrzN+xhmlj22jpCnjrUqJctm+LBM3zgpA8v
 7KnJuwKbJiiAt2DiNzrQNNFym4H0RKs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-nIt7q6wKNLiHsBeAa5pDyg-1; Thu, 02 Jan 2025 02:43:58 -0500
X-MC-Unique: nIt7q6wKNLiHsBeAa5pDyg-1
X-Mimecast-MFC-AGG-ID: nIt7q6wKNLiHsBeAa5pDyg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so61561885e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 23:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735803837; x=1736408637;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2vQN1wzPnw5ph8G5snpj7cU/03MkaA5m52ofg5pvDs=;
 b=joVbHbJY1/+qGaC6LYJHzkXvvzqPg2RQDXsGj1YYxJPponi8Wdn1Hw3juPlopn6Cti
 SE/2pBVG9oHILGOuoXWseoVU++V4aB8r0Mkdzk86P3NTmVb8ILDtbROS4HOXxqwal3Ao
 pxE4vdcRXsAlCc9hGaOke4OXMH6yyknmV2n9ExEW2KddorcZDfgOv3uU7Ewt0zKBu6wv
 MCGSsdYG9zEbAz5CQZwKi14WXCFX+Kxn+6lj+B73m1ckgHMQdfm5oF7BCFIMQMBTt5aq
 i+xSdUjjaZOuKi5+BNgruZ9FiZvc43g4z/22w5qow19LcbV3eZyai/mX2KiUcVIFyeN9
 T1wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyB5s+TvBiffuYtz8RETT/UtKYbG8wSMMwUSxtso7t3Ta4KLIigt1AehvPGmPAzFlwaWM8hT+uEC3X@nongnu.org
X-Gm-Message-State: AOJu0Yz7KBh7IbdZVXOQ6f6ldYkVtWOpHxqIKbzBRt1bdchYmraf6wnE
 2AwZ6BZf6eiV+DQhJhRhRCbAEt0yBksYAv64a4o0aH38J38bMjSkUlNmyMqNN3YZKNfq8GT7u+V
 WZM4MMwsZqxx0KiHw0bkUMlfkSeM3XA0o5HqMRkJoy2b+WfM8UUvv
X-Gm-Gg: ASbGnctEtr+jpQvwX1roX/TgpNLEkdEtCv5H/ZcHo/JKqxa0n0azchjHPRLc+AN95T+
 531yPD0XVTNfAsdRee9ZjkgdP68Puzx3hHdapTqgZFLIyKKtDa81FGNfV2UqQFeFuTMR5RgL2/H
 klkNUbRGYG0rt8F9LR0m/Eg7yx34LI/5kmQuk9T64WR/mbpztV9BW1E/pCqVi4gXLGV+rs/Gd6v
 4Nvj3t0PgqAqWYtc53gbVmA2w234VSuxAisN8ztYLUe/md2Q0hp2xC/IDuP6RxaPaVs7SBOmvM7
 PB3daTus55yk
X-Received: by 2002:a05:600c:45cf:b0:434:fbd5:2f0a with SMTP id
 5b1f17b1804b1-43668642e7bmr391233315e9.9.1735803837298; 
 Wed, 01 Jan 2025 23:43:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsLdMUyn4I5gSUINezZTlAJXh6eAYR78VPUOWukLd42oqw4k+vlngCk9ArjbQ+TVT7i2XiHA==
X-Received: by 2002:a05:600c:45cf:b0:434:fbd5:2f0a with SMTP id
 5b1f17b1804b1-43668642e7bmr391233115e9.9.1735803836900; 
 Wed, 01 Jan 2025 23:43:56 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-148.web.vodafone.de.
 [109.42.51.148]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b013e1sm472231555e9.12.2025.01.01.23.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2025 23:43:56 -0800 (PST)
Message-ID: <5dc130c8-2084-4e6f-86e2-21427f08ab33@redhat.com>
Date: Thu, 2 Jan 2025 08:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Addressing CVE-2024-3446 in qemu versions shipped in debian
 bullseye and older
To: =?UTF-8?Q?Santiago_Ruano_Rinc=C3=B3n?= <santiagorr@riseup.net>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Chuhong Yuan <hslester96@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <Z3MrCyX8tVQMPjz7@voleno>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z3MrCyX8tVQMPjz7@voleno>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 31/12/2024 00.21, Santiago Ruano Rincón wrote:
> Hello there,
> 
> (Please CC me since I am not subscribed to the QEMU devel list.)
> 
> I am working on backporting some CVE fixes to old Debian versions
> (bullseye and previous), and I would like to ask you some help to
> confirm if QEMU in those debian releases is affected by CVE-2024-3446 or
> not. This is QEMU 5.2, 3.1 and 2.8.
> 
> On the 7.2 branch, the following four commits are required to fix
> CVE-2024-3446:
> https://gitlab.com/qemu-project/qemu/-/commit/e070e5e6748e3217028fa21aa30bb51f862368c8
> https://gitlab.com/qemu-project/qemu/-/commit/6d37a308159766cb90ed745cfeb1880937b638ec
> https://gitlab.com/qemu-project/qemu/-/commit/e7c2df3fd748a20a8b7a316d186b3ac77551f159
> https://gitlab.com/qemu-project/qemu/-/commit/7aaf5f7778de4d75a169ab193f08857eb28db3a4
> 
> AFAICS, the qemu_bh_new calls were replaced with qemu_bh_new_guarded in
> 7.2.6.
> 
> Please note that 6d37a308159766cb90ed745cfeb1880937b638ec (and
> ba28e0ff4d95b56dc334aac2730ab3651ffc3132) include this bug as reference:
> https://bugs.launchpad.net/qemu/+bug/1888606. Could you please confirm
> the CVE relates to the same issue?
> 
> I am unable to reproduce the issue. I've tried the reproducer found at
> 6d37a308 and the one from the ubuntu referenced bug. However comment #5
> in the ubuntu bug mentions it was reproducible with QEMU 5.0, so I am
> confused.

  Hi!

Just to double-check: Did you compile your QEMU with address sanitizer 
enabled? Otherwise you might not see the issue when running the reproducer.

  Thomas


> To summarise: it OK to affirm QEMU 5.x and older is unaffected by
> CVE-2024-3446?
> 
> Thanks in advance, and happy new year!
> 
>   -- Santiago


