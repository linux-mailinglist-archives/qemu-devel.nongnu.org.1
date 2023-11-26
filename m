Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 875597F95EC
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 23:51:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Nwl-0002i1-Kx; Sun, 26 Nov 2023 17:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r7Nwf-0002gF-JG
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:49:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r7Nwe-0002Qd-7U
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:49:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40839652b97so24596165e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 14:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701038982; x=1701643782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gidROEQg6roQhbvPcrsWjtNGEGxoxRyhv8t3KmEDtTg=;
 b=NLwbCEey3/B2lAL6XyzxYz6FFtKMj/oxDNffsUJnWI9Re0upg0BXrw2QIVLV93ADVq
 eJzprW7eKS2H0WVceoTpwxfk+p/oGsD0RNxtmxo1x2Xiu2i6OFB9YXxnhBpk+IzaHwYu
 JgE9iBhueQylwWGTUBW0/idvQkM4nfre1slil+FCOuxzLnoWLD5mHX5KcXbDQ8Tip2GI
 hSCZbL+ghQirJKwzvKzp/UVnKfhwiODhMYi+Ijb/XUHlqQhCs4DzRYElD9Rj3htPqEQi
 d2OmHUVq+hzPewIQ/0ybfjS6/pqV0FgbV0N3yspq9cMrvnh9LhLIh/njEJ09CKkIGHUa
 apfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701038982; x=1701643782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gidROEQg6roQhbvPcrsWjtNGEGxoxRyhv8t3KmEDtTg=;
 b=g8tNMY+07hdQoPG5Nl+82jFtkeaa8mU+V6vdAX6WIguCG160ekT41jt6TZfQ5lVU2I
 spJthamFirrqWHocOrUN8BAoSThwyWYaxyw0ZbDfxnUC7v4cxrCuzEEdiYMinFp7o6Kq
 PbQG3CC6diqZkReFQKOmfiNccrN1FwjaWrltoE7L7pnv3np/dHSw1o401cWHuVYPbTF9
 1oOgSe98AB0P7WY6gs3yXqVXKqw9rt/vgxgmbQXy/fXJs6yKsq/XQSXtKBx3jVqyeSRQ
 DHIC7A0a/51OQ7Gof8ynHNiwjHdtT1GTWRoLBIZeeJmVHvJ/770zjBU6yG1+nQ2DWXtq
 fd5g==
X-Gm-Message-State: AOJu0YxSOEKRZOkkEoXbPk5raoFKCjXJQErLoYRns6oipfKodswJSBPA
 SxWIOSU4QeCd8rzCTJqI+BY=
X-Google-Smtp-Source: AGHT+IGYZb7FgPazoOkfEPG84jJ449G9oGIiX+L79PbC7wXPgXn1Fhk4KxpL0ARjN9/3oOOiB0t7YQ==
X-Received: by 2002:a05:600c:3b16:b0:407:8e85:89ad with SMTP id
 m22-20020a05600c3b1600b004078e8589admr6659720wms.14.1701038981794; 
 Sun, 26 Nov 2023 14:49:41 -0800 (PST)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab?
 (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz.
 [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05600c34c500b0040b349c91acsm12342903wmq.16.2023.11.26.14.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 14:49:41 -0800 (PST)
Message-ID: <82b2394a-a110-4741-b5ec-f4df40e2e827@gmail.com>
Date: Sun, 26 Nov 2023 23:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
To: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
Cc: pbonzini@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 qemu-devel@nongnu.org
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
 <87msv065vx.fsf@telecom-paris.fr>
 <3380b626-0d94-489f-bf98-6146c1420a51@gmail.com>
 <87il5o64yf.fsf@telecom-paris.fr>
Content-Language: en-US, cs
From: Petr Cvek <petrcvekcz@gmail.com>
In-Reply-To: <87il5o64yf.fsf@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=petrcvekcz@gmail.com; helo=mail-wm1-x32b.google.com
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

Dne 26. 11. 23 v 14:03 Samuel Tardieu napsal(a):
> 
> Petr Cvek <petrcvekcz@gmail.com> writes:
> 
>> Actually I was thinking about mentioning it in the commit message also, but I wasn't able
>> to find any specification for that (if all compilers use it).
> 
> Note that this change would be safe: at worst, some compilers don't use __tune_i386__ and the situation would be the same as today without the patch.

Good remark. You're right.

> 
>> Other problem is the __tune_i386__ is also set when -mtune=i386 (but with -march=i686).
> 
> Indeed, this is the case for GCC (not clang).
> 
>  Sam

