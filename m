Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7409A92889C
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jul 2024 14:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPhvS-0003A2-9p; Fri, 05 Jul 2024 08:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sPhvQ-00038R-C9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:20:28 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sPhvO-0001j3-OV
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:20:28 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f39bso2179039a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720182025; x=1720786825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJW869YmlCIAYzX0Hbf3XJ2muKOBcrbLR8ldy6V+obI=;
 b=V1GOJVuIl2pWtGtyWsqioTEfhO6A3dwuUmlAJN46gM7sIrGlUd7p/liiXFMarQ8676
 RGpO6dWA/G61+nSHi3y6kdShScSPRVw79Z+8VmN506kwOm5dKBgxjYK7hz+hnOcONOyF
 zIe4Q4zEBZMour57HSykici79xC+I3VoNq0zcWP/0lYMeNdssGsCiuLxZv7rflEUvDKe
 uM9NSI8mtED1fQryEjob591GXZs3w0IGQ87zRPCrm3E65AMyCFbOFaNVtHlDzk4NzmTc
 uGvO2OYl8LU4i3lO4oFZ4e4dMDmEQyzZV8Z9eqFjLEdvxe3zK+2u3/Fdf8/hneI+UFxm
 DSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720182025; x=1720786825;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJW869YmlCIAYzX0Hbf3XJ2muKOBcrbLR8ldy6V+obI=;
 b=mb37/n5nvsXWkMIIfcL0KjkNS+T6urPAy/xMydrLTMPUEZsJSB2OIiK6EEixYBWuok
 j8OfNkZGeHMQHzzb4kV0pkwsgkgpF0iDa2UAMcydgTykfapXQJ2vnoZWw9cSTwcod1RT
 T8X2uDmOnjmqWMatmYc5esutPNtkMFqnmdkicRwKYVBN07xjtNpXC8WLikX1qUNuejyw
 SxxBFcAlUXq3l+b6lRQWg6JfJhs21SrUCM3PFR68atTKQQYlsJDT3rayjhgUkor3+GYG
 qZ8Z9R7xHpresaRskWWgnvM3mns1EARcctf8Zqhlgy4rIvWbGYLfLvH+KDGiH3ONujJv
 D01w==
X-Gm-Message-State: AOJu0YyICKplqrzY+B4Aw8hxtK6z87oOjwpInivt9X704FBe9WFrHYz4
 R4JL7Aef6iEW4fKIrJcbFFNUduYNwGIjsh9q8WgVG1jiS48lroAz
X-Google-Smtp-Source: AGHT+IHOWua0yGxwDXRgfK0yqCn5Ceo9S861fFSwDHPpbUa/8tQZZVofzOG/9YGI7ahBqVUqWDPbcQ==
X-Received: by 2002:a05:6402:1941:b0:58c:c29c:2b73 with SMTP id
 4fb4d7f45d1cf-58e5b4afc25mr2691501a12.40.1720182024829; 
 Fri, 05 Jul 2024 05:20:24 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-230-110.77.191.pool.telefonica.de.
 [77.191.230.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59001f30e7esm466377a12.81.2024.07.05.05.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 05:20:24 -0700 (PDT)
Date: Fri, 05 Jul 2024 11:46:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_17/20=5D_target/arm=3A_Do_memory_typ?=
 =?US-ASCII?Q?e_alignment_check_when_translation_disabled?=
In-Reply-To: <5E575AFE-7E8F-4CEA-999E-30D9881104A8@gmail.com>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
 <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
 <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
 <CAFEAcA-BD1TmaBB_5ephnRoNsOCWsS4w3C_oj0P_182+fOLPUQ@mail.gmail.com>
 <C27AC9E0-AB61-483E-BF07-B435AABE3D13@gmail.com>
 <b871bf81-ed1a-4720-ae70-9dbc517f155e@linaro.org>
 <5E575AFE-7E8F-4CEA-999E-30D9881104A8@gmail.com>
Message-ID: <FC32203C-AD71-4032-9219-9CACB8AB36FE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 27=2E Mai 2024 17:49:26 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>
>
>Am 27=2E Mai 2024 16:20:44 UTC schrieb Richard Henderson <richard=2Ehende=
rson@linaro=2Eorg>:
>>On 5/27/24 08:29, Bernhard Beschow wrote:
>>> I think the kernel's output indicates that the MMU is active:
>>>=20
>>>    [7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f
>>>=20
>>> AFAIU, the value in brackets is a virtual address while the pte's are =
physical ones=2E Furthermore, the `info mtree` QMP command tells that the p=
hysical addresses are RAM addresses:
>>>=20
>>>    0000000010000000-000000002fffffff (prio 0, ram): sabrelite=2Eram
>>>=20
>>> So I think we can conclude this to be "normal memory" to speak in ARM =
terms=2E
>>
>>Normal and Device are attributes on the page table entry=2E
>>See section G5=2E7 Memory region attributes in the Arm ARM=2E
>>
>>But it's unlikely that the Linux kernel has messed this up, even back in=
 4=2Ex days=2E
>>
>>If you want to make any progress, you'll have to share a test case=2E
>
>It's a proprietary guest, so I need to strip it down first=2E This may ta=
ke some time=2E Thanks for yor feedbak so far!

I finally had some time to look deeper into it=2E While this patch trigger=
ed alignment issues, it is not the culprit=2E The culprit is that the sabre=
lite board sets arm_boot_info::secure_boot =3D true which causes the Linux =
kernel to run in EL3 mode where hardware alignment fixing is apparently not=
 performed=2E Setting it to false fixes all problems and the guest boots ju=
st fine=2E

Question: Does it make sense to ignore the secure_boot flag on direct kern=
el boot? If not, what do you suggest?

Thanks,
Bernhard

>
>Best regards,
>Bernhard
>>
>>
>>r~

