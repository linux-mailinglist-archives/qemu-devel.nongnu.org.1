Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F62716B9D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43XW-00059G-9t; Tue, 30 May 2023 13:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q43XT-00057a-TJ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:53:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q43XN-0000e9-0b
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:53:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b041cceb16so21441295ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685469215; x=1688061215;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JlXuOP3FS+tvAv/Dwg8rDD9UG6GAcIKDnTosL0eBSv8=;
 b=xL57LNrjKvZBsCVUsj168X9O6kYWTV7jcw3gAE/D3zN0IFHRPgSf3eP0SKRd/Wx0S9
 9Pl6s7pmIDB40b2CJby1nzJY5TliqxoEDokG1J0FKOHb1IunkaJA6O5yZnNS2LhBkwKR
 m1LTolJpgB5lQKJIGtcF8cIQB7uP0v8Ul2chye1F9fptDQlCgjHF7Pbho1c+JUdMCDtP
 tNIpiaAPQui8AhO5gzmLzXBGROygF2Z2yDui9Fxh7rQXCdBpDH90kOFc4HDNkz9H1Jxl
 egv1HgrFOBv1OnuREg/DLO6QhsAQmBPKRCB5LFiU8jsmN2oPEsX70/DNGRjNYaTkCkBk
 hSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685469215; x=1688061215;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JlXuOP3FS+tvAv/Dwg8rDD9UG6GAcIKDnTosL0eBSv8=;
 b=aDNSicySGXGpaMWc+W3+OPmPqeaB+2Pzq2FWaWjIHHjdrdHEuUQ0C7OHcB8xJWGk1U
 V8LyNTRdnDfauOFwDzljV1uX1iJPUMvpQgMV9yLPG57jDZKkp02PZ4ZftXM2UxkcWAlO
 L1R/YwtUbNGtKQ+g3OmwHxTre5d8Y49ueun10e9ysKU2srMtB5gHXHG/AdV+caFTmCKJ
 RG7kxOqQkr59/qLBHDWPTLfmEyXViZ0+UhS08vHdmJo+tELDq+IsD6umU3F/+065mi2r
 7YqqLl800/kIokauRtv2oJAyufHB0W1QqKr/VHFr9cctx7AjRZfXdwNuI30jEcD8sg/5
 5OMw==
X-Gm-Message-State: AC+VfDwGuLyM6i+8thrwfJpAnsK7OxZMTvTMqp7gk1WOM0y4onkXsAGB
 H4Bc1R51I8ZMdsMK3fz9Zgf2Hg==
X-Google-Smtp-Source: ACHHUZ4zSkHA85QGWeq3m6FvDiW9iiNnx/YBiGnnEpXb8ueAhp6i1X9OxK9hQkCXymQniuiI2BZk0w==
X-Received: by 2002:a17:902:e546:b0:1b0:3224:e53a with SMTP id
 n6-20020a170902e54600b001b03224e53amr3775818plf.20.1685469214848; 
 Tue, 30 May 2023 10:53:34 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902bd8d00b001ac8e0ea157sm864699pls.144.2023.05.30.10.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 10:53:34 -0700 (PDT)
Message-ID: <7a6af6cf-b018-5925-824e-142911ed0e0f@linaro.org>
Date: Tue, 30 May 2023 10:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] Use docker "stable" tag
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Camilla Conte <cconte@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com
References: <20230522174153.46801-1-cconte@redhat.com>
 <20230522174153.46801-3-cconte@redhat.com> <ZHY0zjnzp6/RSa7Y@redhat.com>
 <ZHY3K88Qs83W3ZPY@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZHY3K88Qs83W3ZPY@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/30/23 10:49, Daniel P. Berrangé wrote:
> On Tue, May 30, 2023 at 06:39:26PM +0100, Daniel P. Berrangé wrote:
>> On Mon, May 22, 2023 at 06:41:51PM +0100, Camilla Conte wrote:
>>> Use the same tag in all jobs.
>>>
>>> Signed-off-by: Camilla Conte <cconte@redhat.com>
>>> ---
>>>   .gitlab-ci.d/container-template.yml | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
>>> index 519b8a9482..11569dd900 100644
>>> --- a/.gitlab-ci.d/container-template.yml
>>> +++ b/.gitlab-ci.d/container-template.yml
>>> @@ -3,7 +3,7 @@
>>>     image: docker:stable
>>>     stage: containers
>>>     services:
>>> -    - docker:dind
>>> +    - docker:stable-dind
>>
>> For reasons I don't understand, this change is responsible for all our
>> failed CI jobs involving Fedora being unable to resolve DNS
> 
>> AFAICT, the ':stable-dind' and ':stable' tags are no longer even supported.
> 
> And I found confirmation of this:
> 
>    https://github.com/docker-library/docker/commit/606c63960a4845af7077721eb3900c706f5d0c5e
> 
> "This will remove the "test" and "stable" aliases for whatever
>   major release comes after 19.03 (so once the next release comes
>   out, "stable" will become a stale alias).
> 
>   I'm not 100% sure this is the right answer, but the "stable"
>   alias has definitely been a huge source of confusion very
>   recently (and it doesn't have much meaning anymore anyways
>   given the death of the "edge" channel)."

Excellent, thanks for the sleuthing.


r~


