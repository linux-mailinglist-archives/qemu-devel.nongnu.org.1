Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A1DB21221
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Aug 2025 18:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVUa-0004FW-3W; Mon, 11 Aug 2025 12:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulVUO-0004CK-JA
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulVUK-0004L0-HI
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754930101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1pOmgDlvE+T96jHgbZgIZK/n2yNBd0FhE423z1C6SMo=;
 b=Sz8jHb+2f77j3T2YCVyb7M+GHh2cLQI/08fTOIhu4a5gvR8iZ2SfI5b3zjUQWn0BpEeDyq
 vjLNhLL/fJvprwpc5vLa/4u2+PAnuF6DA3/WnAGJgpxda9pJDkNKSr8WWvTqUkxUxDBCWI
 dHTxSzxlcCvp3Q+oimjAkY+ROF7DWNU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-YMvA8JCSPxytR8J1meeeRw-1; Mon, 11 Aug 2025 12:35:00 -0400
X-MC-Unique: YMvA8JCSPxytR8J1meeeRw-1
X-Mimecast-MFC-AGG-ID: YMvA8JCSPxytR8J1meeeRw_1754930099
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ae98864f488so476058666b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 09:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754930099; x=1755534899;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pOmgDlvE+T96jHgbZgIZK/n2yNBd0FhE423z1C6SMo=;
 b=nYONnRUh43ebw2W/yySLpfZ0MHvHVqVkPiBOyAQRHU2tBqgGCsECzes9/teJ0M5yh1
 27veGqAecdJR/sKAUuCUDjd/UxMAedvSVtBkEINqv7Y6hw2BavVdj4iFsJpUvDn/TnR9
 J5vWtMwtkl/b/Z/5bP8liPJpWPTCarr6soy/iPQBA9AZQ8j1ezB3pf6qxHsKcftjZKaR
 j6vARao0Ap5rXd2k7WKrP+8N/wkVqwuabiNLtElFolcMTEYgKwtXrSeyRwaYNWx9j1Ad
 M2eLn9dqr//ANOag6Dvj5DZ1PWYUXhV0xHKP3yEGjOU/mpAgrprzAxAGAhkBZ586i/2M
 1T8w==
X-Gm-Message-State: AOJu0YzCcQDbGkAw14h08rn7QJxpV/A65ins6Y7ZINT9XSAkWIc/SJTU
 d9UopHDWjA+D2vGg1SrPJ17HgyL7X8AIfk4g/jhU+OMjZMiJux//IyeKgurivhm8U+Q/BuDjIvf
 GNxoOMlqbqMEHsZiRXcAdkWDCC8h8fkisGB+FzNZ/7TPcfYEumS0/cxrG
X-Gm-Gg: ASbGncuRJzPs1kLLSDrAIkfUSMf+IRhqH+9tLPwN5fcn/rJfXwN9uc8e7LMMp2AjnWS
 1LJ5r1euhEYBklmjwehOH6ZXs6uc0O0YmREfYrY6GTtfecdo93lybNrSP8NBjGuDpn8xTFf3myF
 ULjPwzL68zblahggjkB/XsUdwv1ij6et/oKgg6/Y+hePdxgwGNwYXbWL28aCwZpvNMS0TuAk01T
 C4ePTTx8ZlavOK2zEIYXH7yxF3phpA3OdwkjeDmvUKm0rAQir5JM4NdewaDYH1fFPLH0oUGjGny
 zykHV47xx/riBbk6vPgxVoPXw2Jb89LAZU1sAlfWYpv8fv7Q5W7Wgz3QAEV9gnoFTXyixQmmHky
 c2g==
X-Received: by 2002:a17:906:6a0e:b0:ae0:b7c8:d735 with SMTP id
 a640c23a62f3a-afa1e15676emr6278766b.42.1754930098964; 
 Mon, 11 Aug 2025 09:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/VR11QfS45Ossr1H+kkLkGLyULlIHsmFQ5cRDma0yPcBwPmkFYEslZ/hrrxe05T5COJfiQQ==
X-Received: by 2002:a17:906:6a0e:b0:ae0:b7c8:d735 with SMTP id
 a640c23a62f3a-afa1e15676emr6277266b.42.1754930098540; 
 Mon, 11 Aug 2025 09:34:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a07643asm2053661466b.15.2025.08.11.09.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 09:34:57 -0700 (PDT)
Message-ID: <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
Date: Mon, 11 Aug 2025 18:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
To: Kunkun Jiang <jiangkunkun@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>,
 'Avihai Horon' <avihaih@nvidia.com>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

+ Avihai

On 8/11/25 18:02, Kunkun Jiang wrote:
> Hi all,
> 
> While testing VFIO migration, I encountered an corner scenario case:
> VFIO migration will not be aborted when the vfio device of dst-vm fails to transition from RESUMING to RUNNING state in vfio_vmstate_change.
> 
> I saw the comments in the vfio_vmstate_change but I don't understand why no action is taken for this situation. 

There is error handling in vfio_vmstate_change() :

         /*
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
         migration_file_set_error(ret, local_err);

> Allowing the live migration process to continue could cause unrecoverable damage to the VM. In this case, can we directly exit the dst-vm? Through the return-path mechanism, the src-vm can continue to run.
> 
> Looking forward to your reply.

I suggest you open an issue on :

   https://gitlab.com/qemu-project/qemu/-/issues/

with a detailed description of your environment :
   
   Host HW, Host OS, QEMU version, QEMU command line, Guest OS, etc.

A template is provided when a new issue is created.


Thanks,

C.
  



