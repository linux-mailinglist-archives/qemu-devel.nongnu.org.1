Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B84719B41
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4grW-0002eq-FS; Thu, 01 Jun 2023 07:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4gr9-0002WU-Bu
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:39 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4gr7-0000TH-DW
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:39 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30ae4ec1ac7so698727f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685620355; x=1688212355;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8tQ9FG2SJWN+3t53cRA/TXIHkLi6SqW6Ynucwii2qk=;
 b=Y2uRtAr65TF2e3kwr5IasFMy1KL9Ef2fvd/fqrcQFk+/syMm/r2xAPJqst0hIWLeh1
 tvOpKVSs1vT91IQekIfnxHGHqcMXV2ztShXVp1Hgm4Po0+MwwnDUoQnvRbjtsAIyCJxr
 yImDTcGBoyZz9fADLZKVihK/Sr44ItwcCpMrX8ZA4wPm4cH7IYeOs5j5UiSV861rxJod
 t4ct7LqpnS/3yNymn7Ki6XtMvKJFo92TfWkWIZh91Nq58r7WPYbDqaHTfXb6zkOs8fNj
 DwCw0pC1AqnQEqBNqKv3aOde3uKqeCk0Kwum9R1yUqiU5n8mWTndarX+E7OaOfLkD4f1
 a+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620355; x=1688212355;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S8tQ9FG2SJWN+3t53cRA/TXIHkLi6SqW6Ynucwii2qk=;
 b=dV9eFXgTReG3bMQea7ycMx2adNwuaOszuZKJGGwa4ZDD0650rJACBKubzxutPNXfD2
 0yjsIU6PbRszPrdFM2qzU1+mjM8DY7OhEoYtd3DrziJ6EkXuthWGm/EvHFln/USeb5NK
 sMEuufxCKLCliNwdhEfGFsuMu8QuYKtSTpw0Esezgiwy2XIIh1yKuWwM2BDZZ4p49fqD
 vKvEEpaCPN1glInw7ldRIg+7ZvyCEL0SGdqsAZpprsQ0Ku2SVtq493JRP7mChVxSyNyH
 4mC3PJUkXt7qheQcQiDWTPvsM92oFQAIGFmaIvNWYs3gei6dUQUlmUpP/TeodLnbgsNu
 TKSQ==
X-Gm-Message-State: AC+VfDzl6AJP5G0u+h9Zjd4EvRiY05ksXZ9aGprdNqbYWob2Aw3s0CJK
 o50Wak86ODDrArq6/vhjGNbXFJQp1WRFEtiZ3K0=
X-Google-Smtp-Source: ACHHUZ51NfmG82SKJfF7QB+NWeuul/XfM7D3MTIipn2TD87LbSJ392DxAHPx4dpOWwGlqNGkA1jhQw==
X-Received: by 2002:adf:e3c3:0:b0:30a:e00e:8af7 with SMTP id
 k3-20020adfe3c3000000b0030ae00e8af7mr2178469wrm.63.1685620355361; 
 Thu, 01 Jun 2023 04:52:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfe881000000b0030631a599a0sm10167680wrm.24.2023.06.01.04.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:52:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 60B8B1FFBB;
 Thu,  1 Jun 2023 12:52:34 +0100 (BST)
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-5-fei2.wu@intel.com>
 <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
 <ddc552ba-c95d-4b31-01d2-a6d70a978f1c@intel.com>
 <a6a88248-4142-baa6-dc86-b6d471477384@intel.com>
 <87cz2idt3m.fsf@linaro.org>
 <ec09d167-18af-9170-3d35-2d55fa6112d8@intel.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v13 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Date: Thu, 01 Jun 2023 12:51:14 +0100
In-reply-to: <ec09d167-18af-9170-3d35-2d55fa6112d8@intel.com>
Message-ID: <87bkhzbdrx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


"Wu, Fei" <fei2.wu@intel.com> writes:

> On 5/30/2023 6:08 PM, Alex Benn=C3=A9e wrote:
>>=20
>> "Wu, Fei" <fei2.wu@intel.com> writes:
>>=20
>>> On 5/30/2023 1:01 PM, Wu, Fei wrote:
>>>> On 5/30/2023 12:07 PM, Richard Henderson wrote:
>>>>> On 5/29/23 04:49, Fei Wu wrote:
<snip>
> ----------------
> IN:
> Priv: 1; Virt: 0
>
> 0xffffffff800abe14:  864a              mv                      a2,s2
> 0xffffffff800abe16:  85ce              mv                      a1,s3
> 0xffffffff800abe18:  8526              mv                      a0,s1
> 0xffffffff800abe1a:  46bd              addi                    a3,zero,15
> 0xffffffff800abe1c:  fffff097          auipc                   ra,-4096
>               # 0xffffffff800aae1c
> 0xffffffff800abe20:  cc0080e7          jalr                    ra,ra,-832
> ------------------------------
>
> Look at the tb with phys:0x2abe14, although the first time IR takes
> 75274ns, but in the second command we can see it takes much less time
> (Note IR time is accumulated).
>
> So if the time for the same TB is not consistent, and the deviation
> could be dominated by system events such as memory allocation instead of
> codegen itself (?), I think it's less useful.
>
> Alex, regarding dropping time profile, do you mean remove TB_JIT_TIME
> completely?

I think so - perf would do a better job of separating system events from
the core code as it has better visibility of the whole system.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

