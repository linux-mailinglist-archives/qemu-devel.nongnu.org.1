Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FAC7B7F2F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo13z-0001vd-VQ; Wed, 04 Oct 2023 08:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo13y-0001v0-0W
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo13w-0008Vx-I2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696422791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZ3xUPpQDL3eDr7Mcy0fW2XhB8yjLvrwD1Xikb5R5/8=;
 b=Pja+XVDJsfz3Dx/1St+0Vimq7UXn7wWUTluDispxufXyZXP/zZRrm7NK4ph+6ohcISYady
 cvtZvlDroUiXmP248+pq30mlasXNLgbQ83T3VSSOr1mhXyvohb2X3Qwk5YM/HDdgQSL1SZ
 AQkkYcX//l2rhnnWfCEqgNrz/u5XMFI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-5o3pmsOrOVi3ETxNMuz5Cw-1; Wed, 04 Oct 2023 08:33:10 -0400
X-MC-Unique: 5o3pmsOrOVi3ETxNMuz5Cw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77407e21d49so228525885a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696422790; x=1697027590;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZ3xUPpQDL3eDr7Mcy0fW2XhB8yjLvrwD1Xikb5R5/8=;
 b=QEsHLx1vWueuOWPpUnPH7r91PwMO40pq4ciEcW2F526wSMUveG0zYodByqToxQX5+R
 s/C2QZed2FCON6arX3Ua2aI3qqoAcdNZ2IfP+aLIYR7klawEapX1vRp5ZqOSRZBpDL3q
 R9VBajyXaKBryPwBjf+E9taAD1YPQwiG8YH6dCdwW0jG4k27XlSIYJyhPjQpFF7HvSFR
 d+1G9BMgRWLZbNe6CaLB7QYOojVGSf+ylwRdDSvFQlYHcvzY5GpB/CyvSdogho+Xzgbd
 wPnbkBDPTnQI+HDOc8WZ16zLn9E9gPx8lOjb0J00yTBFDI4M90ewCZMGgFH0HtiHTsjj
 kZGQ==
X-Gm-Message-State: AOJu0YyEJEs074pLZiYJmQdDllpnCsBiOts0fpXksD02OUSBlAnWH7Ub
 6ln/BYdmvUs3p6mhRHFifpHr3hc0sIPkyvYQRwuR3eB0QWlqmB8wAA3npuXwcux/tpbGoTJyTeq
 p1Wg9fpLdrp/IpgE=
X-Received: by 2002:a05:620a:4085:b0:775:68c8:79f7 with SMTP id
 f5-20020a05620a408500b0077568c879f7mr2829662qko.0.1696422790241; 
 Wed, 04 Oct 2023 05:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw4ueMmOP3VMv6pVIr5vKGis1v5+oFz5v903I+Vmmlt+xA+ZNkWPS9aPBejKlaSIe9e8Nieg==
X-Received: by 2002:a05:620a:4085:b0:775:68c8:79f7 with SMTP id
 f5-20020a05620a408500b0077568c879f7mr2829646qko.0.1696422789956; 
 Wed, 04 Oct 2023 05:33:09 -0700 (PDT)
Received: from [10.200.209.159] (nat-pool-str-u.redhat.com. [149.14.88.107])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a05620a15a400b007756c0853a5sm1211464qkk.58.2023.10.04.05.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 05:33:09 -0700 (PDT)
Message-ID: <da746afe-eff3-fdde-58ae-e1c2d0b6e672@redhat.com>
Date: Wed, 4 Oct 2023 14:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 09/16] semihosting: Clean up global variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-10-philmd@linaro.org> <87lecih9a7.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87lecih9a7.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 04/10/2023 14.16, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Fix:
>>
>>    semihosting/config.c:134:49: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>>    int qemu_semihosting_config_options(const char *optarg)
>>                                                    ^
>>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
>>    extern char *optarg;                    /* getopt(3) external
>>    variables */
> 
> I'm going to assume the getopt.h is somehow swept up by osdep.h?
> 
> Anyway:
> 
> Acked-by: Alex Bennée <alex.bennee@linaro.org>

Could we maybe rather remove getopt.h from osdep.h instead of renaming this 
everywhere? getopt.h should only be required by some few files, so including 
this in osdep.h seems exaggerated, IMHO.

  Thomas


