Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282307BB2CF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofqV-0001eb-7n; Fri, 06 Oct 2023 04:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qofqR-0001e5-50
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qofqP-0002n3-5z
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696579555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHuq+hlm85/mP7xaLf1nq9nmhJaAwJDMmagbMErhntA=;
 b=Hs3NcbLvK4iy9MF4Sq2XtEM2HCWHbQ80Mlo0i8g2JhOj38wP0/I5izENMFScliq6jOIS3C
 +jGWbhvFJSvTIZAoLFbhEhMI4nbvdmnWbEDwuxhhjM+O6/lPn82oI2X+o1qUK9AeIjXJBK
 HF4SbYBzInxhWvcdb/jlsjT1rmiWkrg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-0xYUOQY7MR6ZMlABqSUOIQ-1; Fri, 06 Oct 2023 04:05:44 -0400
X-MC-Unique: 0xYUOQY7MR6ZMlABqSUOIQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77593f7173eso242276785a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696579543; x=1697184343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHuq+hlm85/mP7xaLf1nq9nmhJaAwJDMmagbMErhntA=;
 b=iTVmEXbaRcOIdcQ5jR2WeXhh8zNo+nz6uDi1HwVfzZ/7lRRgEjIwFV4B08KDeEBvMf
 2ICMdiZAOEpf0cz+A6nyrHtaKqNDphAz0G6aEbsDdwnxZbD+hXPNglUkdI0Ppc0/4vuT
 cwipxM9K45nmMCQ9y2cKIfueKoEUhyXRytkVlN/at6+6tm8Fdrt3dUsRUsiAjROHuo8M
 WHKQpR8nC5qhObmhkup6dyoptQcXhGzKYQK4IZlO8/9oMhUcMoRaZFukmJxrVEi5RD26
 +eU0QVfvcUjF5xji30zZzQ8qTNPJp7RXOzc2pmfKNQFyiLGfb2Kn07Z26gAtCGrqWqAE
 xuzQ==
X-Gm-Message-State: AOJu0YzDq8z0HynmpJoYNH35lB+pDtGxMWAOq0wmFS5SYje6T7AJmZ9l
 NWEtkEu6dh4Vd+wt9R1iymfqDLphcrRdc13jAYVCHLf7TukhkO/jPNlpny+lqb8/9gvge3VZ6Se
 afvYP37eNttHMPpg=
X-Received: by 2002:a05:620a:21db:b0:76c:af30:3281 with SMTP id
 h27-20020a05620a21db00b0076caf303281mr7411359qka.10.1696579543469; 
 Fri, 06 Oct 2023 01:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+c0jlYArS958o9kdH7a3U5Xr6MJwqQya9wwrGt87zSMOgoVp+gZwogaC+2bpvbZrAF/aLLw==
X-Received: by 2002:a05:620a:21db:b0:76c:af30:3281 with SMTP id
 h27-20020a05620a21db00b0076caf303281mr7411329qka.10.1696579543201; 
 Fri, 06 Oct 2023 01:05:43 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ow10-20020a05620a820a00b0076f35d17d06sm1115242qkn.69.2023.10.06.01.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:05:42 -0700 (PDT)
Message-ID: <92e28781-fde6-ca3d-219f-972db5c05da2@redhat.com>
Date: Fri, 6 Oct 2023 10:05:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v25 04/21] target/s390x/cpu topology: handle STSI(15) and
 build the SYSIB
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
 <20231005160155.1945588-5-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231005160155.1945588-5-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 05/10/2023 18.01, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> On interception of STSI(15.1.x) the System Information Block
> (SYSIB) is built from the list of pre-ordered topology entries.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   MAINTAINERS                      |   1 +
>   qapi/machine-target.json         |  14 ++
>   include/hw/s390x/cpu-topology.h  |  23 +++
>   include/hw/s390x/sclp.h          |   1 +
>   target/s390x/cpu.h               |  75 +++++++
>   hw/s390x/cpu-topology.c          |   2 +
>   target/s390x/kvm/kvm.c           |   5 +-
>   target/s390x/kvm/stsi-topology.c | 334 +++++++++++++++++++++++++++++++
>   target/s390x/kvm/meson.build     |   3 +-
>   9 files changed, 456 insertions(+), 2 deletions(-)
>   create mode 100644 target/s390x/kvm/stsi-topology.c

Reviewed-by: Thomas Huth <thuth@redhat.com>


