Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE92E7284BA
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7IMN-0002rT-4q; Thu, 08 Jun 2023 12:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1q7IMJ-0002ox-Tm
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:19:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1q7IMI-0004fj-9G
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:19:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f730c1253fso5791395e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686241171; x=1688833171;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwKUa8ldcngen6GFhrQGPs6NKhjNvVO+0IjnDh0+dEg=;
 b=mV2eb4QebznzdXRTfSzI4mPrQEtLf8gVIPxQXUG067rrb2dVARQIZBxwl23g6jNAhm
 A33vpQ/OfXnm3neQUSO1FdVXcw9hr6leZYjPLVgALH7vsfp09cQMM2+TrTf6tVHbxh33
 K8QbkaA9pLo6O+EKzzsTkp6IHjBHDiosyWogNIt9XaVHyVpM8FjndK0bhC7ELd0yFYUW
 BHnFZYpylBnI4gk2TSOaJOPdeFmQsNYnNBYE1ZTRVHJDfFpbJQXM9arvRwuZIF1yv6K4
 VXchAtohrWRNTESO5NzyZiUo3fI7m+3ffHrm7gT44jUb4VNht4Pss7YhWxn9OInqgTKR
 FWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686241171; x=1688833171;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LwKUa8ldcngen6GFhrQGPs6NKhjNvVO+0IjnDh0+dEg=;
 b=TqijCcHJsz7Ti1UHdUgCJ3SWNozNgyZz8Z79nUI0DP1/4dof0mauIKn3FrwZUpF11X
 3+wkrUwpSuI8JB1yn6nBjbftQ8ZsEAHHKNyj0VoLob2OOn1tXkOCHw5e/tBsZjbtzFY7
 gcksAinKFYk+srxnKR7KlKyTWaMGVAi9x/zqK/g1+hRErDsULyU/Y2gBnWDN0AQv1by7
 LuGngIPITierSfhQMi0T0eMdOPRlpQtRh0ImalqtTd573ft2Li/3niKvQKn/kQirUGAB
 IZ1qVcCWVoCNfYLmalY24pN7nQe/r8CIW5vl3VcDVnz5SJfzv5NAOUXbf5pLLZbCBXcu
 IJ3Q==
X-Gm-Message-State: AC+VfDx0VWple29W+Pxxpsr1qzcPMpx6wFUix3eHrA0CQG+O0c+OVksH
 p1Jp40wvtHuQGDPDcXDkTZ4=
X-Google-Smtp-Source: ACHHUZ4hBlwqvctG0hExxD75HdW9a7pGh9GgL5+7XoQjO0fqFANjfyUlIJpXYnEIRqN9Gdc6N7Xh4w==
X-Received: by 2002:a7b:ce92:0:b0:3f6:683:628b with SMTP id
 q18-20020a7bce92000000b003f60683628bmr1905349wmj.3.1686241171203; 
 Thu, 08 Jun 2023 09:19:31 -0700 (PDT)
Received: from gmail.com ([47.60.45.125]) by smtp.gmail.com with ESMTPSA id
 n6-20020a7bcbc6000000b003f6f6a6e769sm73800wmi.17.2023.06.08.09.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 09:19:30 -0700 (PDT)
From: Juan Quintela <juan.quintela@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: afaerber@suse.de,  ale@rev.ng,  anjo@rev.ng,  bazulay@redhat.com,
 bbauman@redhat.com,  chao.p.peng@linux.intel.com,  cjia@nvidia.com,
 cw@f00f.org,  david.edmondson@oracle.com,  dustin.kirkland@canonical.com,
 eblake@redhat.com,  edgar.iglesias@gmail.com,
 elena.ufimtseva@oracle.com,  eric.auger@redhat.com,  f4bug@amsat.org,
 Felipe Franciosi <felipe.franciosi@nutanix.com>,  "iggy@theiggy.com"
 <iggy@kws1.com>,  Warner Losh <wlosh@bsdimp.com>,  jan.kiszka@web.de,
 jgg@nvidia.com,  jidong.xiao@gmail.com,  jjherne@linux.vnet.ibm.com,
 joao.m.martins@oracle.com,  konrad.wilk@oracle.com,  kvm@vger.kernel.org,
 mburton@qti.qualcomm.com,  mdean@redhat.com,  mimu@linux.vnet.ibm.com,
 peter.maydell@linaro.org,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  shameerali.kolothum.thodi@huawei.com,
 stefanha@gmail.com,  wei.w.wang@intel.com,  z.huo@139.com,
 zwu.kernel@gmail.com
Subject: Re: QEMU developers fortnightly conference call for 2023-06-13
In-Reply-To: <673a858e-8437-24e0-1ca5-3a2f956bb42c@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Jun 2023 17:17:14
 +0200")
References: <calendar-123b3e98-a357-4d85-ac0b-ecce92087a35@google.com>
 <673a858e-8437-24e0-1ca5-3a2f956bb42c@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 08 Jun 2023 18:19:28 +0200
Message-ID: <87sfb2apv3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=juan.quintela@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: juan.quintela@gmail.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> Hi Juan,
>
> On 7/6/23 15:55, juan.quintela@gmail.com wrote:
>> QEMU developers fortnightly conference call
>> Hi
>> Here is the wiki for whover that wants to add topics to the agenda.
>> https://wiki.qemu.org/QEMUCall#Call_for_agenda_for_2023-06-13
>> <https://wiki.qemu.org/QEMUCall#Call_for_agenda_for_2023-06-13>
>> We already have a topic that is "Live Update", so please join.
>> Later, Juan.
>
> KVM Forum 2023 is on Wed 14 and Thu 15, so we can expect people
> interested to assist being traveling on Tue 13.

OK, I am moving this to next week.  Being in a call without people
involved is not going to be good.

> There will be Birds of a Feather sessions on Wed 14 from 15:45
> to 17:45 (Europe/Prague), perhaps this is a better replacement
> (assuming someone from each session volunteer to stream for
> remote audience).

I am not assisting to KVM Forum, but it there is a meeting that I can
join online I will do.

Better if anyone on KVM Forum organize this.

Thanks, Juan.

