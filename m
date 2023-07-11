Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50F74F198
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:17:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEA9-0001ae-Pj; Tue, 11 Jul 2023 10:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJE9m-0001Yg-0d
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:16:03 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJE9j-0003XC-Ss
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:15:57 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so13553262a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689084954; x=1691676954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gotq3+VEXwQTLCbf4Ht9ewaB4E8ZBaGC0uCrhGixc2o=;
 b=gGo5Pz4pHyHMvplKGxAfcjsVdH58EE1r1bAMRoQp330OMrrYH8go/jhQI7RRirH0zC
 8RA98l8KtnE+R4cof8IjW7tnn0sfnUCHUSX3u+sSpbfakdm604RiqE6PdY55qNQoBh3/
 1H1wBfrYS1/oF7a2dSxNWFiSPFxjAfxFkCsUiWb135QbKeG4UMeNOcgu3XzpJoo17lTZ
 qDVa5r/uLIobDGrgdsubvR2YyfcU7diuh61w3AlB1nlipA9zezKqfSqPlrWQglT0JdW1
 GFJeBemJ9Eyye5g3bf8aL+gP0dHyUgc96s975q0RT1bT4kyDvGZJrQjZADzls5dwuw6E
 i7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689084954; x=1691676954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gotq3+VEXwQTLCbf4Ht9ewaB4E8ZBaGC0uCrhGixc2o=;
 b=F+7d966e6nO/viaUKcdXIkg4wXIMIAo+9WYa+m3g+jnU3kVbJPc9zEQ865+Gxzqgc+
 aLL0tE9Tvc1Iqb96JO1rzfRJWbMpHPmcsWWsFfAN/G85VdFShP54qcb0bmO/6HaIffcs
 MwvY++2Tqc0JUBKO6789SIQJ3ZW1N3gUYSNMEzrxB+vTNAME7DDSOApnBtHArorjfBPL
 pMwr8YJxAyBpXcDYTS3z5gvnYE6Oy8NLvenrhKLeXqcBvCuzUBpcxfvg/gkPVYgy/CQm
 FcMtK2LnJO28H2Edt2jCRbs+nm1N4aCQPXmtffnvLTF36y0gmeK1DCw7OooZ5doicWem
 j2gw==
X-Gm-Message-State: ABy/qLYCz57LRTA4CEpfcNYTtQwgFLhcCgobmrW4UNuaAYm/xNEuN/dD
 faHlJxbhGHTLicNNftB1iPNW5Q==
X-Google-Smtp-Source: APBJJlGTN5E7ixLFlxw2yQltqkvfTz1GFebsJGuEWZwnmopozBDGSeN6M1tK/FTWu7FRVXBPOpTEdg==
X-Received: by 2002:a17:906:10a:b0:992:ef60:aadd with SMTP id
 10-20020a170906010a00b00992ef60aaddmr19801508eje.13.1689084953669; 
 Tue, 11 Jul 2023 07:15:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a1709064e5200b009930042510csm1204441ejw.222.2023.07.11.07.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 07:15:53 -0700 (PDT)
Message-ID: <279c50d2-41dd-851f-1603-7a2834049208@linaro.org>
Date: Tue, 11 Jul 2023 16:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] tests/vm: Introduce
 get_qemu_packages_from_lcitool_json() helper
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
References: <20230711140143.65818-1-philmd@linaro.org>
 <20230711140143.65818-3-philmd@linaro.org> <ZK1iRcctZmVJPT5f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZK1iRcctZmVJPT5f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 11/7/23 16:08, Daniel P. Berrangé wrote:
> On Tue, Jul 11, 2023 at 04:01:42PM +0200, Philippe Mathieu-Daudé wrote:
>> Add the get_qemu_packages_from_lcitool_json() helper which return
>> such package list from a lcitool env var file in JSON format.
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/vm/Makefile.include | 4 ++++
>>   tests/vm/basevm.py        | 9 +++++++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
>> index c2a8ca1c17..b021b344b5 100644
>> --- a/tests/vm/Makefile.include
>> +++ b/tests/vm/Makefile.include
>> @@ -106,6 +106,10 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>>   		--build-image $@, \
>>   		"  VM-IMAGE $*")
>>   
>> +$(SRC_PATH)/tests/vm/%.json:
>> +	$(call quiet-command, \
>> +		make lcitool-refresh)
> 
> 'lcitool-refresh' is something we only run explicitly when we
> change something about the lcitool, and also isn't provided
> to end users running from tarballs IIRC. So we shouldn't need
> to wire it up to build targets, just commit its output JSON
> file.

Right, simpler. Thanks!


