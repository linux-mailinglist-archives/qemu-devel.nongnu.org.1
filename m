Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD27859FA
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYoSQ-0004ZT-Jb; Wed, 23 Aug 2023 10:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYoS2-0004Y8-1j
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYoS0-0005uh-A1
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692799391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcCvA/w9/6Qd7X4O0mnwWmXgiN/x3yFZVnqIzQs20+c=;
 b=NblHbpJNab/pzGknqHGnawzXdtYckCn3dKyPBBwRth1UnFhynxZyu8wJwa4mf4XMzyXCoy
 SJ76jG5VvRMP7XZBLJcyK/xOHtYVl98QK+viD97N1APjckYUpeIU3aS9Jq07NHECM+iQrL
 p6X0ceBwJv5DjhjTPNah56tDoFqbqDc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-hcoZqyVtO-W4MUfDqAkzCQ-1; Wed, 23 Aug 2023 10:03:04 -0400
X-MC-Unique: hcoZqyVtO-W4MUfDqAkzCQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fed8814117so31774305e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692799378; x=1693404178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcCvA/w9/6Qd7X4O0mnwWmXgiN/x3yFZVnqIzQs20+c=;
 b=OLZbwPfJ/r79bUk0NF5EVdAUPc7b+YCAzzozHHX3nqtBK8UKVBWVEl6HMp2Qqn6R+9
 HC9eyK2IGUsJFDAB0Ync6fC4EWG1oqCParm73+lRVp6gbueGdWaMXxFYylUDK+GPKFJ5
 pL8HrDROvhTjlyDBzRbnfFwT7hepJrpsDOqF1B8ycIS0y34b4o9YZN16BKbZfVcpgVRk
 gF9ymqvJ3seCwY/8SN/0FcyTi7LukdSsevwec5e4c2nnQZFHznRSMTzHjg9VmPI4tuJm
 m6tDYCi8GLPVSZB685r3lMoWnTw3+Sb/UJ9N2e5Myn3V6FIunmVQDJlvxK2igMu0of/f
 kmKQ==
X-Gm-Message-State: AOJu0Yx5hn/Nkps3xa4z1Vx/8bGyEGAXDHZmuK48a5pNkQe/2a9+WgDF
 fZc4XGlj+DTtRl8/b5M7ONt4cLATjkRJo4oyHcA2UVGzJN9gVy1pLiDOpqqybFn9Hxfy84DknvK
 hPvmrt0O0TM/hPTI=
X-Received: by 2002:a7b:cb18:0:b0:3fe:2606:84a4 with SMTP id
 u24-20020a7bcb18000000b003fe260684a4mr9903316wmj.34.1692799378614; 
 Wed, 23 Aug 2023 07:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy5HcVewKp13wxMdz0KFSeKDfTgTIb4P+U7I6QeLuiJjyw0TOxOvFCIV0qEoBKAi/2o+4dgQ==
X-Received: by 2002:a7b:cb18:0:b0:3fe:2606:84a4 with SMTP id
 u24-20020a7bcb18000000b003fe260684a4mr9903302wmj.34.1692799378315; 
 Wed, 23 Aug 2023 07:02:58 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 n16-20020adfe790000000b003188358e08esm19095088wrm.42.2023.08.23.07.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 07:02:57 -0700 (PDT)
Message-ID: <bbe918ca-acd2-3e54-ab65-dcc302ece535@redhat.com>
Date: Wed, 23 Aug 2023 16:02:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 09/12] include/hw/virtio/virtio-gpu: Fix virtio-gpu with
 blob on big endian hosts
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
 <20230823114544.216520-10-thuth@redhat.com>
 <8d9ab679-240e-7e42-8abc-eff80d2e5893@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <8d9ab679-240e-7e42-8abc-eff80d2e5893@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.684, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 23/08/2023 16.00, Michael Tokarev wrote:
> 23.08.2023 14:45, Thomas Huth wrpte:
>> Using "-device virtio-gpu,blob=true" currently does not work on big
>> endian hosts (like s390x). The guest kernel prints an error message
>> like:
>>
>>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 
>> (command 0x10c)
>>
>> and the display stays black. When running QEMU with "-d guest_errors",
>> it shows an error message like this:
>>
>>   virtio_gpu_create_mapping_iov: nr_entries is too big (83886080 > 16384)
>>
>> which indicates that this value has not been properly byte-swapped.
>> And indeed, the virtio_gpu_create_blob_bswap() function (that should
>> swap the fields in the related structure) fails to swap some of the
>> entries. After correctly swapping all missing values here, too, the
>> virtio-gpu device is now also working with blob=true on s390x hosts.
>>
>> Fixes: e0933d91b1 ("virtio-gpu: Add virtio_gpu_resource_create_blob")
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2230469
>> Message-Id: <20230815122007.928049-1-thuth@redhat.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> This smells like -stable material. Please let me know if it is not.
> e0933d91b1 is 6.1.

Yes, please include it in -stable.

  Thanks,
   Thomas



