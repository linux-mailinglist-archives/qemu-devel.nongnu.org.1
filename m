Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4A7A1D60
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6vy-00088P-P1; Fri, 15 Sep 2023 07:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qh6vr-00087g-0H
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qh6vo-0007b1-Ib
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694777055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TBc/uVBazeKY4iJBuo/xzGp3L+IEGUgDpqNfs+vuw50=;
 b=UlQcp91VrrzEcBcD+hgYH1WAITh72d5TXgQiEOz2JprkgQn1wCCk3jsU2FItWiSFLjzQTE
 X+BFGJIXMYsJIoCG8zITxgWYDzPH7YcCx9tzTj4x8XWdp+K2P3P/enEHYdWZ09bm4enJqQ
 DIjWP1moAYLXC7Da4p1vKDXNJvyj8yY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-xbdjK--PMRyiAzwZ-nRvvw-1; Fri, 15 Sep 2023 07:24:14 -0400
X-MC-Unique: xbdjK--PMRyiAzwZ-nRvvw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so1353819f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694777053; x=1695381853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBc/uVBazeKY4iJBuo/xzGp3L+IEGUgDpqNfs+vuw50=;
 b=EI50ubQFfLywDQBgLUiPhRzsgdIFOLguTIuKzqJJPY9MI+2L2gycaNY4vQp2iVpIIU
 F15l8Y849cOuOAfJoxJnLljDiOVjxEepIRLSzN7wCCVi6xmMU7/+om/+MePWFGKbTVRR
 glwAc7UphLdSmHYofxhgKP+amc9aawIH3D+vx5kt2IjClLf8OLL8+t2cbkrRnVhP+7/H
 xadG+Un2xu6nqyMEUaQv69x66QAQeSJRkEgpIhYhXSVOpY9WwY4Wo/6AMP9OtyUiWvGc
 c8veChskniBiMk/0Jp3Z6SuTka15On+IRqChlBq7Sie9tdsE7zrn8bvPkkMKrZKcYudz
 TCNw==
X-Gm-Message-State: AOJu0YzDSG+IW4jYENgAkeZZbko+xxDkkgmIiR8pQBpsz/17U7SbFRFE
 pWef3d8EamGHTV28L9W94pC4+a36X3LIcrcx3HugRoDr5pLSFB8GpdZPZQ2lbEcT7PRsoepU/up
 vyYKWjF3g3PY9CCz9cNMrM6E=
X-Received: by 2002:a5d:6309:0:b0:314:3a4b:6cc6 with SMTP id
 i9-20020a5d6309000000b003143a4b6cc6mr1121831wru.53.1694777053380; 
 Fri, 15 Sep 2023 04:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfzS1bf7I5k4K089S7rfBvdAMDbotC0N/rrzu5TzO/lEHtytbqBRVpJl+wb7RJM3LzhrjGQA==
X-Received: by 2002:a5d:6309:0:b0:314:3a4b:6cc6 with SMTP id
 i9-20020a5d6309000000b003143a4b6cc6mr1121816wru.53.1694777053005; 
 Fri, 15 Sep 2023 04:24:13 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-179-28.web.vodafone.de.
 [109.43.179.28]) by smtp.gmail.com with ESMTPSA id
 s10-20020a5d510a000000b0031971ab70c9sm4208989wrt.73.2023.09.15.04.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 04:24:12 -0700 (PDT)
Message-ID: <665c03fe-37e7-4e2c-666d-156cf70e0f70@redhat.com>
Date: Fri, 15 Sep 2023 13:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/9] tests: update Debian images to Bookworm
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-2-alex.bennee@linaro.org>
 <30ac04ad-eb02-90ad-57ff-089538413602@linaro.org>
 <ZQQi6n+3mp+bQIgu@redhat.com>
 <242dc7bd-f0c4-d58c-fc6a-f3ddc0168bf2@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <242dc7bd-f0c4-d58c-fc6a-f3ddc0168bf2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 15/09/2023 12.53, Philippe Mathieu-Daudé wrote:
> On 15/9/23 11:24, Daniel P. Berrangé wrote:
>> On Fri, Sep 15, 2023 at 11:14:29AM +0200, Philippe Mathieu-Daudé wrote:
>>> On 14/9/23 17:54, Alex Bennée wrote:
>>>> Bookworm has been out a while now. Time to update our containers to
>>>> the current stable. This requires the latest lcitool repo so update
>>>> the sub-module too.
>>>>
>>>> For some reason the MIPs containers won't build so skip those for now.
>>>
>>> Debian removed mipsel:
>>> https://lists.debian.org/debian-devel-announce/2023/09/msg00000.html
>>> https://lists.debian.org/debian-release/2019/08/msg00582.html ...
>>
>> Wwith our general aim to support latest release, plus the previous
>> release (capped to a maximum of 2 years), we can still consider
>> mipsel supportable in QEMU CI by sticking with oldstable (Bullseye)
>> for the mipsel containers.
>>
>> Once Debian 13 comes out, however, we'll be discarding Bullseye
>> from CI and so we'll be unable to do CI for mipsel. At the very
>> least this means we'll consider mipsel to be downgraded in terms
>> of supportability when that happens. We might then consider
>> explicitly dropping it as a buld target entirely, as the writing
>> is on the wall for 32-bit OS platforms in general...
> 
> I'm fine with dropping system emulation on 32-bit hosts, but a bit
> reluctant to drop user emulation there. Anyhow I agree with our
> distrib releases support rules, so the mipsel buildsys part is
> effectively condemned.

Could you maybe send a patch for docs/about/deprecated.rst to make this 
clear for the users, too?

  Thanks,
   Thomas


