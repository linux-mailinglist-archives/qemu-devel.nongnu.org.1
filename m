Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7D75C07F
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 09:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMkxd-0005dp-Rv; Fri, 21 Jul 2023 03:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMkxb-0005db-JF
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMkxZ-0006dU-L8
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 03:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689926036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qeB9IVy5h26w/mT1nMZlpH/2CqgaX2jIa2P+0l4BoM=;
 b=UAFJKRBspylbwVwQuEKJrTpptCDHQhIUtzL0cJiMofl4Ul6SDF/guX4OzZpCwo7ijAwymy
 dE4r3PpalPiBetgQKgP+sySWRovFzclAA1S8ZsMYIy+MHTTuZic7szgY+mnrYqPT4z9yQW
 umfVUc2O7oLig8F5cfY17pdeVwuHPNY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-kkvMApveMP-K9xVva4_VHQ-1; Fri, 21 Jul 2023 03:53:54 -0400
X-MC-Unique: kkvMApveMP-K9xVva4_VHQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so9390675e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 00:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689926033; x=1690530833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4qeB9IVy5h26w/mT1nMZlpH/2CqgaX2jIa2P+0l4BoM=;
 b=fy6SPGfVnczbMpbD/V7ekqZRAiKPqRfI13QYK09TuulbchtuKEGO2zo5jf2pzfprRg
 DRhyvH2yns98DeVbk9Majq7fTH8eybj5ESR2kKe6u2akCBRAdCTtnfuohiODQ2UZIExO
 ui1aU8LaVf65dlG/EVp+sKMI0I27qBzluSV71A1MwGiRZiO9Yw4aE5NvbRMBD6V4JUiG
 1XLFV6JBNgSa5n5RPF9gAAvKA8NFlRiP5ctvBdR+V0P0LASX2+01KdcPtmyeo2JWGDJb
 i39TGD49koM7hrZjbngxY6YMf7x2AMUH1Ckg2Ae36QrFdFHIjU7wc8mgvZZAPShCEfsI
 1ypg==
X-Gm-Message-State: ABy/qLYGJJOkD7CjlfL/DYJ4zrWDdt6L5UWq8dRCF9OihRYKuD8hzpHO
 vQLK+gcOD0QqDwxu+95pa5JicJ6EnXVl4EgWIbfu/vOnZ5fzprdMAsVv8oI4LrdrT4VjXPOyOY4
 uC1BT+ZTH75Re2v4=
X-Received: by 2002:a7b:c8cc:0:b0:3fb:a100:2581 with SMTP id
 f12-20020a7bc8cc000000b003fba1002581mr855808wml.14.1689926033023; 
 Fri, 21 Jul 2023 00:53:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0xWO3fyKN1BImFNm82vsXbeEwOtEzyV+DzgdQ2eA0v62qed3Dsurgcb7GQ+Z4gJk2OvJ3gw==
X-Received: by 2002:a7b:c8cc:0:b0:3fb:a100:2581 with SMTP id
 f12-20020a7bc8cc000000b003fba1002581mr855798wml.14.1689926032739; 
 Fri, 21 Jul 2023 00:53:52 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-165.web.vodafone.de.
 [109.43.177.165]) by smtp.gmail.com with ESMTPSA id
 k5-20020a05600c0b4500b003fbb346279dsm2810747wmr.38.2023.07.21.00.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 00:53:52 -0700 (PDT)
Message-ID: <3e350fee-a54a-f7e6-4476-e31f1c3d0430@redhat.com>
Date: Fri, 21 Jul 2023 09:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: 8.1-rc0 testfloat fails to compile
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230720224656.2841ff5f.olaf@aepfle.de>
 <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
 <20230721090359.1b9797cd.olaf@aepfle.de>
 <10e95d52-109a-d683-a9ea-2ab9b52e795d@redhat.com>
 <20230721093513.515b2306.olaf@aepfle.de>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230721093513.515b2306.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/07/2023 09.35, Olaf Hering wrote:
> Fri, 21 Jul 2023 09:18:08 +0200 Thomas Huth <thuth@redhat.com>:
> 
>> Or are you compiling with -O0 or something similar?
> 
> Does the master branch compile for you with 'export CFLAGS="-O2 -Wall -Werror=return-type"'?

Oh, this fails for me, too! I thought that -Wreturn-type would be part of 
-Wall, but apparently it is only enabled by default for C++ in my version of 
GCC :-(

  Thomas


