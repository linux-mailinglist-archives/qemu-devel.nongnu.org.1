Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 574177481A7
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzLt-00025V-LT; Wed, 05 Jul 2023 06:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzLp-0001z3-7m
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzLn-0004WL-Qf
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688551386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcn+7FSWO3Q6p4kQd9xNkcM9RaSbtdZr+9l8xzd+0w4=;
 b=jAs1qAo61SnGk9xlZ2TqUFOB8ZTTW6WRzDFcbpJRuHzraHb7Bx7HmJPhmUbmz3sHiiS4JI
 CA/U4AQPSSATyOGj5t4ELtaFDQAKKK2iHrv9xWXqTvoDliBJ+leVxJED2XHthehIfwUifV
 kmF/6yDamapvaKZ5enUasyebjs+zanI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-AN7K1FbwPeK2MzVuXbOlvA-1; Wed, 05 Jul 2023 06:03:02 -0400
X-MC-Unique: AN7K1FbwPeK2MzVuXbOlvA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6372702c566so13889026d6.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 03:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688551382; x=1691143382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wcn+7FSWO3Q6p4kQd9xNkcM9RaSbtdZr+9l8xzd+0w4=;
 b=E97Wab2Mbrj0PVLgXvkxKax6MUJRA88uOx+yy0fBZ4zyafPrL81X89Y6iGzogEL591
 sO18PejlzG6oFB16Y8+UTLqt02P3OAIlT8dku6CTWcS2dj9w0D7oH5BwYbYPD9s4m36k
 jqcGXW3GT9k3iaGiV7bauD8NyYo2JgYAlGs7grNY07rls1MkjPnPnQ9WK1oKHYIR1ROt
 rflzuWYt3YyUhY5FAPU+Dp2mavRsuvKTyHj1rSck+ItkDySKEGiZu2ONIK7litWMYx5/
 KUXABshpUOjY3dyGUx5ttWSyvvMdmJiulpKttVH055ddj/xWLfscsjrfo9NHteBkdwRG
 r+yw==
X-Gm-Message-State: ABy/qLZWLd4TT3OwwmqOdWeuyczyHMMtmMoww8ACj41jMpPc45qEPmOf
 x3v4XOP8+9GJ1njAKLVyEUc1Y/CEtt8hQMhZ4qbhnKDmqys+5JzVGcXNXy/kzQXaYohtwHgain5
 IqDQQ5Mn5SiWjYBo=
X-Received: by 2002:a05:6214:528e:b0:636:fda0:a23 with SMTP id
 kj14-20020a056214528e00b00636fda00a23mr6501921qvb.27.1688551382508; 
 Wed, 05 Jul 2023 03:03:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHRo34E4ELVzciCfO6o6DgM67R0waGD/cUsmQW3QZt8hvDcwxLibx/OTtVskYC+A5fGCWt9Vg==
X-Received: by 2002:a05:6214:528e:b0:636:fda0:a23 with SMTP id
 kj14-20020a056214528e00b00636fda00a23mr6501909qvb.27.1688551382291; 
 Wed, 05 Jul 2023 03:03:02 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a0ceccf000000b0063642bcc5e4sm6541019qvq.9.2023.07.05.03.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 03:03:01 -0700 (PDT)
Message-ID: <e5387fc9-f8b0-3905-8b48-88409c251710@redhat.com>
Date: Wed, 5 Jul 2023 12:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 00/20] s390x: CPU Topology
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-1-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 30/06/2023 11.17, Pierre Morel wrote:
...
> Testing
> =======
> 
> To use the QEMU patches, you will need Linux V6-rc1 or newer,
> or use the following Linux mainline patches:
> 
> f5ecfee94493 2022-07-20 KVM: s390: resetting the Topology-Change-Report
> 24fe0195bc19 2022-07-20 KVM: s390: guest support for topology function
> 0130337ec45b 2022-07-20 KVM: s390: Cleanup ipte lock access and SIIF fac..
> 
> Currently this code is for KVM only, I have no idea if it is interesting
> to provide a TCG patch. If ever it will be done in another series.
> 
> This series provide 12 avocado tests using Fedora-35 kernel and initrd
> image.

  Hi Pierre,

the new avocado tests currently fail if you run them on a x86 host. Could 
you please add a check that they are properly skipped instead if the 
environment does not match? I guess a

  self.require_accelerator('kvm')

should do the job...

  Thomas


