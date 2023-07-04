Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0426E747153
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGf7j-0005HM-IQ; Tue, 04 Jul 2023 08:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGf7h-0005Gv-KY
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGf7f-0000N6-V0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688473630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1DVV9YwOzEbvqEsOsygUElF9BNPHfcGIhILStRd8EE=;
 b=gKYJffEW/30zgR0IdzIC65z1qO5Nlw/bHudklzBFCzIC9mhmqgliK8gLaU6XntuF9ADOu7
 VVGFSATsRafBDp6qaXGraV8KwmNxrYSgwiDDYUc0MJLoVm6Y13cfEDrGxkrEjP9lml7bgW
 x4eSG6DB8Kwi0VVdQ+apwq6VYgnNAS0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-sCkUEuitNBClUzLvvAHXew-1; Tue, 04 Jul 2023 08:27:09 -0400
X-MC-Unique: sCkUEuitNBClUzLvvAHXew-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7656c94fc4eso669105585a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688473629; x=1691065629;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1DVV9YwOzEbvqEsOsygUElF9BNPHfcGIhILStRd8EE=;
 b=JaRno5vsuJq+yzdusWQGk4/gyPVL6LkgLXZR55EgzImVGThAKwYHW30WXcNQCm08eh
 MFjwlIwrxckGGD8TRrE4TdlLMJE/ZqKw9U7vZzyFg3tTAgfaTx2uOKu2tkZEJplNQ0N/
 WyDAZ381Z25h8U4rCrd7vujwnDwPMRMD6+oSTLg0vy3lDs7DFEniZEn/HSWOc0UjNYCf
 K3DZnisEyFihat9N+jEKdFrAdbS+bn1jWY2F1A8RG0nlKZKkDZKBYAAalTwPfZ/9y0nL
 4kI/pg54N/CmJIIdyttHLYjfaB+SVho1dj/Gspt7804opy/w7c5YaUE3Yh+TmPHAJ21n
 ckYQ==
X-Gm-Message-State: AC+VfDzcxxIuEsDmTkQjIWYaNUnQ5f5oOAoPFIaEBc4CawmO300Ej+T6
 cSTZ03hZxukWh2sOEEfvxb3feTFk/0mL2yDBrQbLZ/P8euIEVnHhXPA4z/6KhkSjjRDQUu9QWqK
 AZ/jvfr9q1GCA8a4=
X-Received: by 2002:a05:620a:4589:b0:765:67fe:5325 with SMTP id
 bp9-20020a05620a458900b0076567fe5325mr11399710qkb.44.1688473629339; 
 Tue, 04 Jul 2023 05:27:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zjflw9gGwLPQ+6p7/iOq2otzVQcU0pI8fD11P7JCfoU8kTxxOyduW3xPfK9rVb7NpMdhNEQ==
X-Received: by 2002:a05:620a:4589:b0:765:67fe:5325 with SMTP id
 bp9-20020a05620a458900b0076567fe5325mr11399686qkb.44.1688473629093; 
 Tue, 04 Jul 2023 05:27:09 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 dy1-20020a05620a60c100b007676ee76195sm1924994qkb.20.2023.07.04.05.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:27:07 -0700 (PDT)
Message-ID: <dd5c5445-e563-8461-a81b-1c637e69362d@redhat.com>
Date: Tue, 4 Jul 2023 14:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 03/20] target/s390x/cpu topology: handle STSI(15) and
 build the SYSIB
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org,
 frankja@linux.ibm.com, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-4-pmorel@linux.ibm.com>
 <aef8accb-3576-2b10-a946-191a6be3e3e0@redhat.com>
In-Reply-To: <aef8accb-3576-2b10-a946-191a6be3e3e0@redhat.com>
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

On 04/07/2023 13.40, Thomas Huth wrote:
...
> Also, what about protected virtualization? Do you have to use 
> s390_cpu_pv_mem_write() in case PV is enabled?

Never mind, I keep forgetting that CPU topology can't be used together with 
PV (I just noticed after reading patch 07/20).
Not sure ... but maybe a comment here in the code would help?

  Thomas


