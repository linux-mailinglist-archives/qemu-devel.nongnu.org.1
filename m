Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DA7747207
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:01:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfdG-0007dE-31; Tue, 04 Jul 2023 08:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfdE-0007d5-4u
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfdC-0001nj-Go
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688475585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNfu57SAxhSH2gtUbJmmWr6+52WluNp1xeZE/uuspzI=;
 b=WzX6is7R+idhmZYScsx5aUx52XrCKlb2LIgnavAeZ28XvbsJec2dubS0MwtIWWgiBhDmPM
 efRFvLNmy+cOZanXwq5fpmmIAw5lk2pX0DGj05VOUlLsjeAnMudUTscEOIz9EochfgE6sR
 wnXvzVW3yDIo1goxv8hz/e3SQbo0q0Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-0xYRwFBEPxucrtg6NSuz9A-1; Tue, 04 Jul 2023 08:59:44 -0400
X-MC-Unique: 0xYRwFBEPxucrtg6NSuz9A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-763e092c91aso603771085a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688475583; x=1691067583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NNfu57SAxhSH2gtUbJmmWr6+52WluNp1xeZE/uuspzI=;
 b=eIQ5jd1lwEf3rhTuUF3XeNSaxK0w+hll7hw+QiE/ZfLybhsd2qut8ur49bx/9HAd2y
 aiIU/LDl4v4Of52S76OWq7n+R64NxYO4xmnZyHQyF8qX/mUIB6ZP1tEqpiCu3pkfeA8a
 pa4urzLl8ZacWRJrYzZU5JdKX6NC/v4v0oSIjTYQIPL3FH/iUK06XyzWl0+HND/w5kBw
 zHNtuRQGdGRcFdq+Ldh7i1wqlip52aXFWLxC2xwwjjMdoZWoJwpfUmIoPTcJIk64uWZG
 5hyK3HDFl3NsdUlr9ghS+9i/yElktN/5EJ9iPMPPJBm1RVn4Yzf6sKAoDBQTKa2L3wv7
 /jbQ==
X-Gm-Message-State: AC+VfDzqdvXb8MNwkMZHKYFo9B9eZJWQhUfbe9lXuNu5aHgOcBRLKCBW
 fa+xFPQ7TVHi0D/DGNmgmQq5cPXE0X8f4lxgYNJWDqMVZoPR7H+rcspLWphc+fseLfVMCnC+Qlf
 8MTKaL/PHIM/Y5Jc=
X-Received: by 2002:ac8:5993:0:b0:3f6:a965:3359 with SMTP id
 e19-20020ac85993000000b003f6a9653359mr18181894qte.47.1688475583787; 
 Tue, 04 Jul 2023 05:59:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6k16EJWY9TAYNqSD/sIeGNyekRhajaclUKXaqTi3/9ZMb0G8lvHp2QaqvAe43vri/nv1DLaA==
X-Received: by 2002:ac8:5993:0:b0:3f6:a965:3359 with SMTP id
 e19-20020ac85993000000b003f6a9653359mr18181865qte.47.1688475583509; 
 Tue, 04 Jul 2023 05:59:43 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 ga9-20020a05622a590900b0040327381dbcsm7519645qtb.19.2023.07.04.05.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:59:43 -0700 (PDT)
Message-ID: <843e8472-3af9-ccc5-f6b3-3423d67b9d8a@redhat.com>
Date: Tue, 4 Jul 2023 14:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 10/20] machine: adding s390 topology to info
 hotpluggable-cpus
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-11-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-11-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 30/06/2023 11.17, Pierre Morel wrote:
> S390 topology adds books and drawers topology containers.
> Let's add these to the HMP information for hotpluggable cpus.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   hw/core/machine-hmp-cmds.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index c3e55ef9e9..f247ba3206 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -71,6 +71,12 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
>           if (c->has_node_id) {
>               monitor_printf(mon, "    node-id: \"%" PRIu64 "\"\n", c->node_id);
>           }
> +        if (c->has_drawer_id) {
> +            monitor_printf(mon, "    drawer-id: \"%" PRIu64 "\"\n", c->drawer_id);
> +        }
> +        if (c->has_book_id) {
> +            monitor_printf(mon, "      book-id: \"%" PRIu64 "\"\n", c->book_id);

I think the output should be left-aligned (with four spaces at the 
beginning), not right aligned to the colons?

  Thomas


> +        }
>           if (c->has_socket_id) {
>               monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
>           }



