Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696C7937CA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoYf-0007kx-09; Wed, 06 Sep 2023 05:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdoYc-0007ic-90
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdoYa-0004h5-97
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693991439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoKeGWUnutd/9mI6FB+QpcAQUG9ZXbLAn2pLmAg+HKM=;
 b=eRfhaj2Uu4CiVPl8sEtpN9TPTysSQ+b2tG4kGEqbx0Xr8FJpztJIIYHuYFWxg/tdeJQ5Xu
 0mRo0PbfMnrzLDdk1+iGb2KDPuYWTMiya8LE7ltJiKWy1H2iZUzzmTNcLi47CDO5tUY5z5
 7DOXYy4W05F6VrVv3jXWIMMLCDSs0iI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-5EfttBYZNAWzaR28xzoTjA-1; Wed, 06 Sep 2023 05:10:37 -0400
X-MC-Unique: 5EfttBYZNAWzaR28xzoTjA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bcc5098038so38610141fa.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991436; x=1694596236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FoKeGWUnutd/9mI6FB+QpcAQUG9ZXbLAn2pLmAg+HKM=;
 b=Ky0Y0Ucr618dPci2Zyz6q8wqMOUETftiJ6ndoZfEYJQmehKqZTjse+w4j9AUn103Um
 u7wC2bW3sO6D2511gcvGI+uZH5ivesln3RN5sk8hoIhKs66H1RGhIDJIEL7XJWclVKIu
 X11yLQmF+f9evoLg7ALDWg5VVcr10Wo7IvNC1bY9bXhprh9ht+hwcAyrSepK1jvvlUg1
 wqhkevHWBPOiCqBaWDe6qNdY8AYJRgwG2lc2G/eqzGfyCapNlbDFBKQyO+Mfquf6ty3b
 IMCvOaaemOzqmQeQOHABr2ZQvCJvrQuxK4YEUQJ3I2xMxX4c/B1jleZzl0pBQ1fh38nc
 rqWA==
X-Gm-Message-State: AOJu0Yxo4CW9Gorr9L+nsyefhWkZfr5sdmQNsDVW9hfadk24Q+AXrEbu
 293yBVGJUkEHGYOEYM9gZXAAG+8GanYM82nAZwkh36pbPFMXxQi+GFNMq41/t/OW534thMqu2Ky
 uSZ/yGZsLt2cEuPA=
X-Received: by 2002:a2e:7d0c:0:b0:2bc:da4a:4649 with SMTP id
 y12-20020a2e7d0c000000b002bcda4a4649mr1840262ljc.22.1693991436343; 
 Wed, 06 Sep 2023 02:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE43p5TU7/mW5ls38sUmKEcEBP8143LDuLK6N0yDNc2SF2xeEdkqkGPH+h5P5K333j2l3toFA==
X-Received: by 2002:a2e:7d0c:0:b0:2bc:da4a:4649 with SMTP id
 y12-20020a2e7d0c000000b002bcda4a4649mr1840236ljc.22.1693991435981; 
 Wed, 06 Sep 2023 02:10:35 -0700 (PDT)
Received: from [10.33.192.187] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 bi6-20020a05600c3d8600b00401bbfb9b2bsm326618wmb.0.2023.09.06.02.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 02:10:35 -0700 (PDT)
Message-ID: <dd727caa-5fad-6013-dcf8-780faf539aae@redhat.com>
Date: Wed, 6 Sep 2023 11:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v22 09/20] machine: adding s390 topology to query-cpu-fast
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-10-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230901155812.2696560-10-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> S390x provides two more topology attributes, entitlement and dedication.
> 
> Let's add these CPU attributes to the QAPI command query-cpu-fast.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>


Reviewed-by: Thomas Huth <thuth@redhat.com>


