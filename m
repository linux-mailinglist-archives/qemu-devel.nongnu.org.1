Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B1379214F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdS3a-0000IO-3f; Tue, 05 Sep 2023 05:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdS3Y-0000ID-Fv
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:09:08 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdS3U-0002sm-Rp
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:09:08 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99357737980so342670266b.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693904943; x=1694509743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lmBE03n+OdAQpOsoL4oHLidAEn4H/1VynMMog9vFdno=;
 b=IFFRL/nXlJdXt00/ur5xjiPK1zTA9zI8AHKFkWVJS/9sj2BcMaQ9uGEta2tjs/Qe2W
 CbO5Xqw++/JhrHrIIQwU/VUS/9NE+25nmmuJyL+MhHjFu2T3gSLh4lGdiecI5zxhMOjU
 bPa0pruHRTKxymOIDo3WvTALQRNQlr8IDju7vxDnMnHHOnWfkKOISest8CLKF0/lPHrL
 O9VSvTeQ/+WKhvuIECzQUw9UOU6XyptnHG3EwEoMAUebgAZBlLHJe9YX0LQGqhxCslyW
 UHhz3qrDAfC7D5azUx12DRjlxgNfas3bkpwDDh/FgRKJ6JTC+bK1ijBs/dARrbwHjvP5
 chnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693904943; x=1694509743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lmBE03n+OdAQpOsoL4oHLidAEn4H/1VynMMog9vFdno=;
 b=U5VYhzaubS2oPjBU3h/qnXMAXhgxfOgjlS0R1QjCjANmJokb7Sv1EVnfnJfyYsr+NF
 l32uEOyKhYM+MIPAcnIhNrjiGFbc3lmiSzNFSaMrTKuHizF/DlIgPEZ7LAd+VVk/wuMW
 IK+AWz2OmbaO7PinC+qy7tHD83e0LzF4I1hSwExtAFZCGzCacmaVkHyWeWiRfQtCVeFG
 AFdHzUbAjkumgWqZHa6vmJnCS63EDA3mhCqklz4Tw09NxBlqDCaWNcReeR0rgNadpPUW
 oG0FaKAs4h3QAZgIXLRZoxuvg1r9e1OVdvY9PIapTWq9VUNgIMnGP6VSTD40v8BuF4UM
 PMUg==
X-Gm-Message-State: AOJu0Yzg/NsA40tgizAzrMXGtNOubWO1DLvquewe73g6BD16lrLN9jZk
 TSMl4qrxdfGBWQUQvf9gAGbjLA==
X-Google-Smtp-Source: AGHT+IEmQIesrYVlEzL/UQRef/or2fp6ZaVht+8KM76YKB13QJr6rlFYSdWMhanH0wYJ3v6wMmMB9w==
X-Received: by 2002:a17:906:530c:b0:9a5:c3f9:c89d with SMTP id
 h12-20020a170906530c00b009a5c3f9c89dmr9188553ejo.24.1693904943014; 
 Tue, 05 Sep 2023 02:09:03 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 dk24-20020a170906f0d800b00992d0de8762sm7321502ejb.216.2023.09.05.02.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:09:02 -0700 (PDT)
Message-ID: <66fc116f-0090-1f57-32c3-523bd3f1baf4@linaro.org>
Date: Tue, 5 Sep 2023 11:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 05/19] host-utils: Add muldiv64_round_up
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-6-npiggin@gmail.com>
 <ef43cbed-ac93-4be1-2a0a-54ffb608871a@kaod.org>
 <52695ffb-9294-f6ad-85e2-da4c3841682b@linaro.org>
 <CVA5N2UCW62Q.1XROBBZ9RWCER@wheely>
 <e32cdddb-8455-7bae-3280-4ab7d33d4a57@kaod.org>
 <CVAOJDUN9ZX3.1WW9S8M3AWBQY@wheely>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CVAOJDUN9ZX3.1WW9S8M3AWBQY@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 5/9/23 05:56, Nicholas Piggin wrote:
> On Mon Sep 4, 2023 at 11:30 PM AEST, Cédric Le Goater wrote:

>> Someone really ought to take over PPC. Daniel and I are real
>> busy on other subsystems. Volunteers ?
> 
> I suppose I should. I could try do the next PR after this one
> is merged.

Thanks a lot for volunteering!

Phil.


