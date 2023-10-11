Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 427587C56E9
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaGr-0006nf-G9; Wed, 11 Oct 2023 10:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaGo-0006n8-Tf
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaGn-0004kA-IF
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xCDW35Jsydve5fteL2DYT+zPavsyQxXNXxbX+oysngU=;
 b=N6WVU/RYBn/tQBQvecIV8dTQeuZs/bas13pzVlQSQsniGq/BkvLsQax2I/gscvb5bW9Xox
 V1Yjb9VP/NzDeFJeIqHiQj3m00EYzJzkWxKbehZoZpniItL2UTysFQ7/4VxVbK2RklBJpf
 0VvGvU+zmjVahYgpU+kssSO8gQ1L3vs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-6V2FozBvOF-vfiq2Cu4wAg-1; Wed, 11 Oct 2023 10:32:58 -0400
X-MC-Unique: 6V2FozBvOF-vfiq2Cu4wAg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so5146695e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034777; x=1697639577;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCDW35Jsydve5fteL2DYT+zPavsyQxXNXxbX+oysngU=;
 b=QLDD7k1LEchFYXYVCQLqab1qGdh9nkjaC899gqhoYiK1EmSYQkLrovLXLS835/VIja
 yRz9qLyeT99lS2uZRgZiu4/2pmt2kXGoymU4SHHtOexGtzkXMvUdkCMMEg5eXzFvNQ2l
 VtHq10UfQqho1mqiHxQrePtbWVSP/oSXoRP+fnYnqerUptjv0vfT08wBJbgnAQCzh1wY
 rUbD+HW7pdr8S1fKqLG0eo2Sw2h8OHktjVbBAxOuK6PQ1HFc1u4GzswBGN31VmhvRj/H
 uUb7uYMKuT4LA+qaMhF6aFXnM3qQDJ2M8HS4IMupAuleIZKmRiCAAnfC5UYW0bc5dXyF
 vqcA==
X-Gm-Message-State: AOJu0Yy/IBwwRRCvXhshVfbLrb1Klnm7yl5mzI1pjtligBpkXW9p4Hnd
 JgVugHgo0uyFPuXSp7fJZSlTAy6fL63mH96VBwMvR24jVK/2YqpOA1O8rUf4VBQ+DiuggUXHkE4
 g24cHbAwtKJx/PiM=
X-Received: by 2002:a1c:7505:0:b0:405:3f06:d2ef with SMTP id
 o5-20020a1c7505000000b004053f06d2efmr15520216wmc.4.1697034777386; 
 Wed, 11 Oct 2023 07:32:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7xcjQw4aDgo67OnYaXC73x+bhhIGsTKi3ibNqCBG1msrlNFS3ShsXzyiIxAtFm7CuRPl+Dg==
X-Received: by 2002:a1c:7505:0:b0:405:3f06:d2ef with SMTP id
 o5-20020a1c7505000000b004053f06d2efmr15520197wmc.4.1697034777068; 
 Wed, 11 Oct 2023 07:32:57 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t15-20020a7bc3cf000000b00401e32b25adsm17153066wmj.4.2023.10.11.07.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:32:56 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel =?utf-8?Q?P?=
 =?utf-8?Q?=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Laurent
 Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/9] tests/qtest: Allow qtest_qemu_binary to use a
 custom environment variable
In-Reply-To: <c28f82cf-6b97-47aa-872a-c2ca0599ff51@redhat.com> (Thomas Huth's
 message of "Wed, 11 Oct 2023 16:30:29 +0200")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-2-farosas@suse.de>
 <87a5sp9rbj.fsf@secure.mitica>
 <c28f82cf-6b97-47aa-872a-c2ca0599ff51@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:32:55 +0200
Message-ID: <874jix8c14.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> On 11/10/2023 16.17, Juan Quintela wrote:
>> Fabiano Rosas <farosas@suse.de> wrote:
>>> We're adding support for testing migration using two different QEMU
>>> binaries. We'll provide the second binary in a new environment
>>> variable.
>>>
>>> Allow qtest_qemu_binary() to receive the name of the new variable. If
>>> the new environment variable is not set, that's not an error, we use
>>> QTEST_QEMU_BINARY as a fallback.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Thomas, do you want me to get this through the migration tree?
>
> I'm fine either way, but please give me one or two more days for review first.

Sure.


