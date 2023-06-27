Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A173FB7B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Hw-000788-Sp; Tue, 27 Jun 2023 07:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE7Hr-00077d-Ns
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE7Hp-0005bE-WC
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687866907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWHeAtibBRNqgmjJtrNvcwigYKgFzcSTmxW61KlvnY4=;
 b=NB9UvJJAfL5rksCMZjd1sEbMtkA1wc4CNPiHKjb+7KBv5+JCPMM09gLy4Bicj0Z4GomICP
 cZP3+i0gaEZq8N8aNTuHNR685QEvi0rog9tu7S/DY9FbJaH4j0F6Yl6L2zS9do8WAbjZiy
 TjLdkduFa9hfJt5ILHqKYRAjnndKXms=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-j9_IY4EIODeq3RcDRuJUAg-1; Tue, 27 Jun 2023 07:55:06 -0400
X-MC-Unique: j9_IY4EIODeq3RcDRuJUAg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-635e664d2f8so18325296d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866906; x=1690458906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YWHeAtibBRNqgmjJtrNvcwigYKgFzcSTmxW61KlvnY4=;
 b=SyXxRV96nT3q5YsxoA477CBoh8zZ0YPT1OGGaLWfCz3ZVKmJlVz9Pu9u1IpR15gZTD
 MKBS2agjwj68qtiSbHNFdqSNj1fX8OKD/WF5eL75FV/0RjrJb34dG90EA2q8hmIJ80x8
 fdy3gSizJte67eKbT6e03HxbaVtL9Y18bCq+fWzxv3IiIGlVs1eZkELQVBDtIJeiGJXt
 B+IIo0PF0230RyRkdRFdctnj9QzAEFJv8zQe7Eykh+DBUfIKIqKtJ9ZQ9ccJbqJ31sSr
 CjyQtuCFvfHC7SRk72dG8numbqGb3hYrKrUMaqI1qNMK6bSgPFMXXV961ztGme/am11y
 nJ1Q==
X-Gm-Message-State: AC+VfDw/UZedeg9UXg8GIwrCp99WXQwGgNamAmYKe3Xc56bZDb2Bxio6
 5LtOLr9pH28OCx5VT68KKTL8DmVr7Uuyiw4mZh/l85nk9pjWYpFJmOK/pO1issOHlYPcSBmJKLn
 o/LGNKFx0GDQtG1U=
X-Received: by 2002:a05:6214:48a:b0:62f:eff9:1b8b with SMTP id
 pt10-20020a056214048a00b0062feff91b8bmr44566689qvb.31.1687866906059; 
 Tue, 27 Jun 2023 04:55:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ718tqXloUSa3woXome95OZJGn+WhNoohfQhydojR0OUwNqehiC4IGVHs6nd7t7DpUOBjEjPg==
X-Received: by 2002:a05:6214:48a:b0:62f:eff9:1b8b with SMTP id
 pt10-20020a056214048a00b0062feff91b8bmr44566677qvb.31.1687866905823; 
 Tue, 27 Jun 2023 04:55:05 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-172.web.vodafone.de.
 [109.43.179.172]) by smtp.gmail.com with ESMTPSA id
 i6-20020a0cfcc6000000b006302207bd51sm4388396qvq.107.2023.06.27.04.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 04:55:05 -0700 (PDT)
Message-ID: <43fda03b-bb93-bd90-5ba9-9e03de879698@redhat.com>
Date: Tue, 27 Jun 2023 13:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] pc-bios/s390-ccw: Provide space for initial stack
 frame in start.S
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-3-thuth@redhat.com>
 <877crp9uq9.fsf@li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com>
 <511457be-fa9b-bcfc-447d-bb79f7873a55@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <511457be-fa9b-bcfc-447d-bb79f7873a55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 27/06/2023 11.14, Philippe Mathieu-Daudé wrote:
> On 27/6/23 10:26, Marc Hartmayer wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> Providing the space of a stack frame is the duty of the caller,
>>> so we should reserve 160 bytes before jumping into the main function.
>>> Otherwise the main() function might write past the stack array.
>>>
>>> While we're at it, add a proper STACK_SIZE macro for the stack size
>>> instead of using magic numbers (this is also required for the following
>>> patch).
>>>
>>> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   pc-bios/s390-ccw/start.S | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
>>> +#define STACK_SIZE 0x8000
>>> +
>>>       .globl _start
>>>   _start:
>>> -    larl    %r15,stack + 0x8000     /* Set up stack */
>>> +    larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
>>                                           ^^^
>>                                           You can also add a macro for this
>>                                           - e.g. STACK_FRAME_SIZE.
> 
> Yes please :) No need to respin.

Ok, I'll add:

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -10,12 +10,13 @@
   * directory.
   */
  
-#define STACK_SIZE 0x8000
+#define STACK_SIZE        0x8000
+#define STACK_FRAME_SIZE  160
  
      .globl _start
  _start:
  
-    larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
+    larl    %r15,stack + STACK_SIZE - STACK_FRAME_SIZE   /* Set up stack */
  
      /* clear bss */
      larl    %r2,.bss

Thanks,
  Thomas


