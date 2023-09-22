Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B47627AB681
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjjPt-0002iW-73; Fri, 22 Sep 2023 12:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjjPp-0002iB-Dj
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjjPn-0000LL-SI
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695401642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtfrqB5aiaDUtN2ITk2JGuz+cOZtU7/lrplbRfpUVUU=;
 b=hqFViCLuvMPb/rLf8UscPbO1igWXp4wcYO0/5QBJBFcgls2V/cVyGTKfqWls5oAO0imdp5
 zGs0uhTEaPA0HAbIRulp3T3hDrfjRkhUYZc9VfmWCcpc+ziqVpMRpLIGOOMxQyi6LWhBX1
 e7CMV0rvE7RVNFtmDehCBpCmGGH1Bgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-nncOopEVMsuWwt3fhfWbhA-1; Fri, 22 Sep 2023 12:54:01 -0400
X-MC-Unique: nncOopEVMsuWwt3fhfWbhA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so18425045e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 09:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695401640; x=1696006440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UtfrqB5aiaDUtN2ITk2JGuz+cOZtU7/lrplbRfpUVUU=;
 b=C9y5/gffLkRevRPhIY4QfJHu2gBT/H6FPDQjruUtoklxR4QeFxU1CMzwHBq5n/VgQh
 qXqPjs1E2pc9ZcfiLApV3fhG1BQ3ZgyILChkz4Wvjs6bYuRYeUMIelnlKd0rvEZoFkwy
 5P/kFgnQDszA/JkbyX9gMGvQUCwCUDc71JVBK1n12ywlzhRpSghw+Fdudsb/uuV0LDl+
 T58O8EBGSY82wwaJH+j9pBA5mnV9PL93u34DrMsaoh0oCmrCsa2Z9EPAOybb0XuwfqrT
 FRcd46tN48EZkLWdvmIZZIb20nMDpQ1jaa2vwZvsFRwycruMxa8Z3bjMAhZvnTduBY4N
 43EQ==
X-Gm-Message-State: AOJu0Ywgfh2YXor9i4V/0U/9pdAxvXvJ8Kqj12S4wnG/x4wGriNNA6mP
 02dwSceIaFroS8XrufjwmoDQ3RCOnQCuNLZdmwH5RAJ5//9wi20dVrO2qgPiHuboVGIsa2bV7x2
 wBASe5d0qOypMwE0=
X-Received: by 2002:a05:600c:22da:b0:3fe:173e:4a34 with SMTP id
 26-20020a05600c22da00b003fe173e4a34mr8063097wmg.40.1695401640197; 
 Fri, 22 Sep 2023 09:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMQ9iFrHw6utIQkAejpP+AoH266TADqphXxkhW216QckS/Q2nIC0VYPSMj7JS9s3kNKRsAGA==
X-Received: by 2002:a05:600c:22da:b0:3fe:173e:4a34 with SMTP id
 26-20020a05600c22da00b003fe173e4a34mr8063079wmg.40.1695401639854; 
 Fri, 22 Sep 2023 09:53:59 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-48.web.vodafone.de.
 [109.43.176.48]) by smtp.gmail.com with ESMTPSA id
 k6-20020adfe3c6000000b003196e992567sm4867083wrm.115.2023.09.22.09.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 09:53:59 -0700 (PDT)
Message-ID: <9cb6d7f8-9cac-3a6a-2587-5cb02f2481de@redhat.com>
Date: Fri, 22 Sep 2023 18:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] meson.build: Make keyutils independent from keyring
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 antischmock@googlemail.com
References: <20230824094208.255279-1-thuth@redhat.com>
 <b28d7472-fc5b-8787-0026-5dbf2d7fcd64@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <b28d7472-fc5b-8787-0026-5dbf2d7fcd64@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 07/09/2023 21.57, Michael Tokarev wrote:
> 24.08.2023 12:42, Thomas Huth wrote:
>> Commit 0db0fbb5cf ("Add conditional dependency for libkeyutils")
>> tried to provide a possibility for the user to disable keyutils
>> if not required by makeing it depend on the keyring feature. This
>> looked reasonable at a first glance (the unit test in tests/unit/
>> needs both), but the condition in meson.build fails if the feature
>> is meant to be detected automatically, and there is also another
>> spot in backends/meson.build where keyutils is used independently
>> from keyring. So let's remove the dependency on keyring again and
>> introduce a proper meson build option instead.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 0db0fbb5cf ("Add conditional dependency for libkeyutils")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1842
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Ping? Has this been forgotten?

I'll add it to my next pull request.

  Thomas



