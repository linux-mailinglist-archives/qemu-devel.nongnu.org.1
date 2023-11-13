Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A130E7E9C16
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 13:23:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Vwh-0008BN-8Y; Mon, 13 Nov 2023 07:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Vwd-0008BF-9V
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 07:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2VwV-00082G-Jr
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 07:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699878084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/j9nRvm1DftuH2JuufRUwaKtVe4aBxrZtSbZddv3c00=;
 b=d9Il/5ChEaMOwCx/H3Nm2YbsR0ztv1H6gP9mxhgcs5QB+s9oWhgHRMV1wlnsSn6lF1sBUc
 1zgjJklT4Rj5O8YNXy8sLXcTq+jMl0PdbocMzK1BQ9p6x0at1k9kZMoeV0lkpklwWz9yva
 hzUkCpIQ/5daNxfRtT9ymuKNN0OR598=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-q0NbuWlqOLyBteJ3uD-pJA-1; Mon, 13 Nov 2023 07:21:23 -0500
X-MC-Unique: q0NbuWlqOLyBteJ3uD-pJA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-778b25af933so529532985a.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 04:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699878083; x=1700482883;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/j9nRvm1DftuH2JuufRUwaKtVe4aBxrZtSbZddv3c00=;
 b=GeaJJnYOBCk4roqhn6syOrPx6haJ13xYk8oL/Cu1WPoR2/iexKwa6z+eUU9wVUzADv
 xuznmrpgFdEi2Ts1FADmtmVYQpJt8IMMYR6cCHzImK7DbkfpXTsxpPcGZhmLtPGUop1Q
 JsYYb9t4Dxd1uh6op12SZls+fKGsMIwqKY0vL+Ttgarigf7xiSPmUrVdjmUYtgVP40A+
 xo69NUyqhh2dKGIcjDE3lub0Vklv8yrAYf7Uo9Rq3n1RWg6AIxQQi+3WrQ8HHAE/cxwO
 LJkKiEEdZTGH5S0O3rsDwhhqMQMfEyQ5tGcUWRBYSS3rGsuvYYGVd0m72HqPSsAIE5SD
 YnKw==
X-Gm-Message-State: AOJu0YwTEulo739BqNQKqHJd1tDbCwaacSvXFthla+XQ54hXSjtBN5Rl
 479K5hPh72AAviMF90IF5ZIfNAohBYGhLqD9bAX7RVUzcPLNCaL3d1BXpFIO4/04zL85XhpOKTE
 VdCRo4tOafq+H+VA=
X-Received: by 2002:a05:620a:a5e:b0:775:8ed7:887 with SMTP id
 j30-20020a05620a0a5e00b007758ed70887mr6518225qka.26.1699878083100; 
 Mon, 13 Nov 2023 04:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFATlH/HsH/0xMvIh1gedf0RK7PFrvDDJTngr+JdGoHvKSTNlawyPxS6ptchydz9ZNehbEKpw==
X-Received: by 2002:a05:620a:a5e:b0:775:8ed7:887 with SMTP id
 j30-20020a05620a0a5e00b007758ed70887mr6518207qka.26.1699878082822; 
 Mon, 13 Nov 2023 04:21:22 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 dx9-20020a05620a608900b007789072e445sm1852590qkb.31.2023.11.13.04.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 04:21:22 -0800 (PST)
Message-ID: <da5aeead-222e-4ce3-8deb-625307e69903@redhat.com>
Date: Mon, 13 Nov 2023 13:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/38] plugins: update lockstep to use g_memdup2
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
 <20230703134427.1389440-22-alex.bennee@linaro.org>
 <91b491ca-5600-4272-b694-37d6c8ba2a90@redhat.com>
 <87r0ktyj8d.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87r0ktyj8d.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 13/11/2023 12.40, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 03/07/2023 15.44, Alex Bennée wrote:
>>> The old g_memdup is deprecated, use the replacement.
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Message-Id: <20230630180423.558337-22-alex.bennee@linaro.org>
>>> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
>>> index e36f0b9562..3614c3564c 100644
>>> --- a/contrib/plugins/lockstep.c
>>> +++ b/contrib/plugins/lockstep.c
>>> @@ -130,7 +130,7 @@ static void report_divergance(ExecState *us, ExecState *them)
>>>            }
>>>        }
>>>        divergence_log = g_slist_prepend(divergence_log,
>>> -                                     g_memdup(&divrec, sizeof(divrec)));
>>> +                                     g_memdup2(&divrec, sizeof(divrec)));
>>>          /* Output short log entry of going out of sync... */
>>>        if (verbose || divrec.distance == 1 || diverged) {
>>
>> FYI, this seems to trigger a compiler warning on Ubuntu 20.04:
>>
>> https://app.travis-ci.com/github/huth/qemu/jobs/613144955#L1914
> 
> Isn't 20.04 outside of our support range now? Otherwise we could add a
> helper to glib-compat.

It's "Support for the previous major version will be dropped 2 years after 
the new major version is released", so we claim to support 20.04 until 2024 
(since the "new major version" has been released in 2022).

  Thomas


