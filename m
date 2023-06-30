Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F65743F7E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:13:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFGjL-0007d1-QJ; Fri, 30 Jun 2023 12:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qFGjJ-0007cp-FR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qFGjF-00035E-Fl
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688141525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yc0I0F8vB5M4J9jqpYjrJ/++jFbPqlcyGOd5Mpm2oA=;
 b=bb1oZAkQGQ6IBGc3Im76q52cDTN+kdB7C8+SFi5XBx2t61r1B+8C+R+2ywctzdVchbpbyB
 rG8ewNrqjbvWjSQlDsnDEmkcJ1kmASvvG0xiymAvBRyNHKWLM3oU/zMs44fiXEQxf1J/pd
 pZ74Rkf6stCxNJt6EAiRwzxvTtK6sSU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-vGPSTo9bMjq6GnmGPDnACQ-1; Fri, 30 Jun 2023 12:12:00 -0400
X-MC-Unique: vGPSTo9bMjq6GnmGPDnACQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fb736a7746so2074254e87.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 09:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688141519; x=1690733519;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9yc0I0F8vB5M4J9jqpYjrJ/++jFbPqlcyGOd5Mpm2oA=;
 b=e7zNkWiSln/lV9r+hRucJ4iclos8LiJrYHi2hySKqRgeqMKh7chtoa1EzV5jy3lIF8
 zqbw9TZQg+r/1UbouD2UsgyRfCwEnJZhlKdLXf1hOBMw9rM99cFAx1dIsWvQSfwkai2R
 TiF4pMNJw9uJ5tu6xFRAH1nUrtrnUmNdJjfkVDOD2L7rlh+99LVqI+tZkqxaXQJN3sEx
 ZyHLRiFDWd/rCg0zcBteOx/hYLGGZsTLDIbl82OiMJcEQv8l9uqwd6PoYEvVqZI517Vt
 eJ0ZLrl34kBFZ39n3DjfE7T87h1Fcj+5aDgvDidtxq3J+3kENuFy3BN7wX0fb2lCd/cd
 4ZAA==
X-Gm-Message-State: ABy/qLZN9VYYPZXN8pRrpukdIW/o5L5J5W0cBC4NCbJBxXI+DmASjIWY
 ZCnilZI9IuOA3RmpFpGf3fTiKFmelHaKaubkEDDRitb3qX4FCuHZExGCsJAdA3kKy2h0n6CIxAR
 Ct81Tym+UMyGkP50=
X-Received: by 2002:a05:6512:1092:b0:4e0:a426:6ddc with SMTP id
 j18-20020a056512109200b004e0a4266ddcmr3117748lfg.0.1688141519195; 
 Fri, 30 Jun 2023 09:11:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHjA4gp5rtAkmPVZU/hPVfmvSCOBTav55VVT+fyB2VmdpA0F1/Ot4wqfqNIHu5dYll558PumQ==
X-Received: by 2002:a05:6512:1092:b0:4e0:a426:6ddc with SMTP id
 j18-20020a056512109200b004e0a4266ddcmr3117726lfg.0.1688141518875; 
 Fri, 30 Jun 2023 09:11:58 -0700 (PDT)
Received: from [192.168.8.101] (tmo-097-0.customers.d1-online.com.
 [80.187.97.0]) by smtp.gmail.com with ESMTPSA id
 y19-20020aa7d513000000b0051d8a512472sm6397839edq.51.2023.06.30.09.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 09:11:58 -0700 (PDT)
Message-ID: <a4706aa4-5cf7-0fa1-7010-1eb7d64f169c@redhat.com>
Date: Fri, 30 Jun 2023 18:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: libvir-list@redhat.com, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20230630150112.435874-1-thuth@redhat.com>
 <258917a6-62a3-8d5d-c651-4a11942801c4@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] os-posix: Allow 'chroot' via '-run-with' and deprecate
 the old '-chroot' option
In-Reply-To: <258917a6-62a3-8d5d-c651-4a11942801c4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 30/06/2023 17.56, Michael Tokarev wrote:
> 30.06.2023 18:01, Thomas Huth wrote:
>> We recently introduced "-run-with" for options that influence the
>> runtime behavior of QEMU. This option has the big advantage that it
>> can group related options (so that it is easier for the users to spot
>> them) and that the options become introspectable via QMP this way.
>> So let's start moving more switches into this option group, starting
>> with "-chroot" now.
> ...
>> +static QemuOptsList qemu_run_with_opts = {
>> +    .name = "run-with",
>> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
>> +    .desc = {
>> +#if defined(CONFIG_LINUX)
>> +        {
>> +            .name = "async-teardown",
>> +            .type = QEMU_OPT_BOOL,
>> +        },
>> +#endif
>> +        {
>> +            .name = "chroot",
>> +            .type = QEMU_OPT_STRING,
>> +        },
>> +        { /* end of list */ }
>> +    },
>> +};
>> +
>> +static void register_teardown(void)
>> +{
>> +    qemu_add_opts(&qemu_run_with_opts);
>> +}
>> +opts_init(register_teardown);
> 
> Hmm.. Is it still register_teardown? :)

Drat. Should be something like "register_runwith" now, of course. Thanks for 
spotting it!

  Thomas

> Other than that,
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> /mjt
> 


