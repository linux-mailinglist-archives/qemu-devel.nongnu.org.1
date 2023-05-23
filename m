Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6A70DD4D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Rqm-0003Rn-VG; Tue, 23 May 2023 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Rqh-0003RY-8Q
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:14:47 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Rqf-0002I5-OQ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:14:47 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-528dd896165so5177522a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684847684; x=1687439684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LisnKb1wXruVTSDpVgKN8DTlV/A+dIPIM6DsODtX3m8=;
 b=SYvl+QDGP9Kk1gUMn7ZVoCRNZot1Z+34z2bo0BEAp3h28iXjlJlmRjI8DXTlFITlIL
 k53BLq5pzL9SztB/Uoa2hexlObJKJhCEhZA1OD1+iahbcShtvr/aQ7EzxsjVp8Gj9vTE
 NdL6CEp3+hLNGqFn4IMHxrjTs39+qcY1OjAw4CCSU0t00y7JJZKgZVkyGDmiJvjXENza
 R+xwPnodDYXPQMdVE8zoSLiHzzaK8PA86ekvlfmgvb9YVubV2RyhuTAegbWTWfj7xoDP
 ggGdeoOcY292bGzvplGk/hs0oWGijKe3KSjzPTFL8YfxhMUuKlKlnmpyDmQvrRoGc6um
 U5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684847684; x=1687439684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LisnKb1wXruVTSDpVgKN8DTlV/A+dIPIM6DsODtX3m8=;
 b=fmneKLR4D8oKrj+PVoMF4vOKuAteP/5w0hRuLa2ygTBVGrK4Flk8Jk+xhs3y1GjwN0
 duBODrsjawzKrrba9qSB0Gbmx8KbFRWhjKCnteE6tHvPtbB9xnhdyhTS3NVMYtvkOpjN
 XTYmpfCn7bdhgIotpUKcwggpn1DX7t8of9usueX3NSyn9kgG6fHfEXSEmL3VjvI56tRO
 INiMncZCDcpXS3kzmi6k4UAnIaeIFJgZgJOyw4PrkyiCasFzGZo7mk1qDz7A4HbRos5/
 OOUZXFOJG8uVSMVdjLXJEp9sAWBPq9EVMRXIzeyRRhn2QS90favwwWEajgjYAknw+tIU
 MTKg==
X-Gm-Message-State: AC+VfDxO9p3k3QXGkpi+l6Cwx+VcSKahkSohMY7fO0tBZ3/9XapXYncd
 Wk+nB37U9OYw++eGAr3sYESsqw==
X-Google-Smtp-Source: ACHHUZ4biyiuZOgYFLVFlxbtRj1n1VHtYXT7QfIEGmG0fgT8Yo/8FIE+NQVQp0x432NfvymIK6dBKg==
X-Received: by 2002:a17:902:c407:b0:1ae:7421:82b8 with SMTP id
 k7-20020a170902c40700b001ae742182b8mr18682510plk.28.1684847684114; 
 Tue, 23 May 2023 06:14:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a170902d70700b001ab0a30c895sm6719748ply.202.2023.05.23.06.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:14:43 -0700 (PDT)
Message-ID: <41b6aaec-db79-d08f-9380-e4e47828c77c@linaro.org>
Date: Tue, 23 May 2023 06:14:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] meson: remove -no-pie linker flag
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, vr_qemu@t-online.de, marcandre.lureau@redhat.com
References: <20230522080816.66320-1-pbonzini@redhat.com>
 <ZGxysnpYm8FtL0VM@redhat.com>
 <CABgObfa+EG62MV-9xG7dtxiXj5ocosXS8kNneAoM_kTbmo0CbA@mail.gmail.com>
 <ZGx22AySUhoZZuW1@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZGx22AySUhoZZuW1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 01:18, Daniel P. Berrangé wrote:
> On Tue, May 23, 2023 at 10:02:51AM +0200, Paolo Bonzini wrote:
>> On Tue, May 23, 2023 at 10:00 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>> I'm curious why we need to do anything ?  I would have thought that meson
>>> should handle 'b_pie' itself, passing the right args to $CC that it feels
>>> are appropriate. I don't recall seeing other apps using meson trying to
>>> handle b_pie logic - what's special about QEMU ? IOW, is it possible to
>>> delete this entire b_pie condition and thus avoid worrying about this
>>> problem ?
>>
>> The issue is that Meson only has "enable PIE" or "leave PIE to the
>> compiler default", while QEMU also has "disable PIE"---which is the
>> messy one.
> 
> Does QEMU actually need "disable PIE" ? It existed in configure of
> course, is there a reason we need to continue to support it in meson ?

We need it for aarch64 runner, because the OS built glibc static libraries with -fpie 
instead of -fPIE, and we get a relocation overflow at link time.

Upstream glibc has been fixed, but there has been no update to ubuntu packages.


r~


