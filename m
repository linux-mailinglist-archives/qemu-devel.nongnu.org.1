Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F07263FB
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:18:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uun-0005UJ-W0; Wed, 07 Jun 2023 11:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6uua-0005Rk-SB
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:17:28 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6uuX-0005uL-MA
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:17:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30d5931d17aso3744293f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686151040; x=1688743040;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Y2BdOp4zFOQRlkJfYQouf/KUEf6CShaaPXp4nhhGB8=;
 b=K2qU49+HJMJrmU5H4Sb1XicsBmFDlLUMA8EmS93CPOtL3jnnl4+rO4La8Yv3V6S20i
 qvODLafoaBG8CsCdnQ9QQ/QgGtnkijFEXOwo79lWXHR2MYHs2h5h7t+BsDlln5aZ70WJ
 w8Gulbi03Hr0AQFbuprcZ5D+XGGHiAEpCWyt3BwoAJSf4H6F/ZcRAdkj3nJcrOsU6r1+
 Svae1fNU+pCax3tztTTz1XnDAAifiK1GFqvX1rARL1Bdw5xzbA/tPnA9UXs+SjElCSPs
 WPtd6GrOaPtDiIcVJDioMQsNTxDIqpl9ZmfyF2PSC0QetalzEH/8CdpVFAVrZOVJcvnq
 rL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686151040; x=1688743040;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Y2BdOp4zFOQRlkJfYQouf/KUEf6CShaaPXp4nhhGB8=;
 b=hRGiFd2StGY2qoiury6rkx5+yuYyTGzUNDN5i/7WQagjBkF/z9cKXmO+o0ZLeqMj0O
 TSbFcaXGQ3U6RDhfjSM0MNxTi+g42dfGXWmI+QEv1u6h6rWvtzgZ9WBS68U758eZ5n8b
 aZ7+UiVUus/JrpDDzkoZGEx5zNfala+Fe/hXDzPQ4lELE841kcu7Cm6Leccsw03GuHJC
 yZgE0cRn5K2I4Ect/1q2iqpv8kMPiRAzSM2lQz9wcrNTxvmDEIiBMBngCJ8pQSS0cMt7
 9B3dq/KoZrEUv/auS7giwu8UD7C+m358xeufCwKGdJlDIOovfw4fBPiDOdQCxJ1TDaQb
 q1EA==
X-Gm-Message-State: AC+VfDzvGhuuMze5CHfT1UbRIxqptjJl+fDlRuGMm3FjEVhGZEjAZT1n
 HCzBtwKpHgHv1ODGUKO5YzUX/g==
X-Google-Smtp-Source: ACHHUZ5cFnNGna0073tkDHVILRhJH396LtzVkR4U/T8iZuHBG5TwwXWoL2v8nNA61ktk+JkmS6IRiw==
X-Received: by 2002:a05:6000:d1:b0:30e:46c3:a179 with SMTP id
 q17-20020a05600000d100b0030e46c3a179mr4788635wrx.30.1686151040098; 
 Wed, 07 Jun 2023 08:17:20 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4c48000000b00301a351a8d6sm15694492wrt.84.2023.06.07.08.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 08:17:19 -0700 (PDT)
Message-ID: <673a858e-8437-24e0-1ca5-3a2f956bb42c@linaro.org>
Date: Wed, 7 Jun 2023 17:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: QEMU developers fortnightly conference call for 2023-06-13
Content-Language: en-US
To: juan.quintela@gmail.com, afaerber@suse.de, ale@rev.ng, anjo@rev.ng,
 bazulay@redhat.com, bbauman@redhat.com, chao.p.peng@linux.intel.com,
 cjia@nvidia.com, cw@f00f.org, david.edmondson@oracle.com,
 dustin.kirkland@canonical.com, eblake@redhat.com, edgar.iglesias@gmail.com,
 elena.ufimtseva@oracle.com, eric.auger@redhat.com, f4bug@amsat.org,
 Felipe Franciosi <felipe.franciosi@nutanix.com>,
 "iggy@theiggy.com" <iggy@kws1.com>, Warner Losh <wlosh@bsdimp.com>,
 jan.kiszka@web.de, jgg@nvidia.com, jidong.xiao@gmail.com,
 jjherne@linux.vnet.ibm.com, joao.m.martins@oracle.com,
 konrad.wilk@oracle.com, kvm@vger.kernel.org, mburton@qti.qualcomm.com,
 mdean@redhat.com, mimu@linux.vnet.ibm.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, quintela@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com,
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com
References: <calendar-123b3e98-a357-4d85-ac0b-ecce92087a35@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <calendar-123b3e98-a357-4d85-ac0b-ecce92087a35@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi Juan,

On 7/6/23 15:55, juan.quintela@gmail.com wrote:
> QEMU developers fortnightly conference call
> 
> Hi
> Here is the wiki for whover that wants to add topics to the agenda.
> https://wiki.qemu.org/QEMUCall#Call_for_agenda_for_2023-06-13 
> <https://wiki.qemu.org/QEMUCall#Call_for_agenda_for_2023-06-13>
> 
> We already have a topic that is "Live Update", so please join.
> 
> Later, Juan.

KVM Forum 2023 is on Wed 14 and Thu 15, so we can expect people
interested to assist being traveling on Tue 13.

There will be Birds of a Feather sessions on Wed 14 from 15:45
to 17:45 (Europe/Prague), perhaps this is a better replacement
(assuming someone from each session volunteer to stream for
remote audience).

Regards,

Phil.


