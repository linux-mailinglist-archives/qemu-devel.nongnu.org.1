Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BBD7CF72A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtROE-0004df-5w; Thu, 19 Oct 2023 07:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtROB-0004bq-6y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRO8-0000Jx-Fu
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697715627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6Cy+4LW6+tEFG7oSWEYyib070mePeApvTeuWzcQgmqk=;
 b=MzIYuJYgB4BGXS0w0HmghWQ8YCZApmEjq6dpjgUse2IDjmfsWmiQfmmi4dPPnS8t1gNa9O
 f3Kbf2LM5l7iagPk6dLm06/OXPGkTx3GqKQw6IJR9jqPooRYLI4cToI8+50C8123wUh26x
 oKQuvy68IIxSobWe0AVWNg2ezPeedwU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-bL3-vDNwM6uSMRGnbyY2UA-1; Thu, 19 Oct 2023 07:40:26 -0400
X-MC-Unique: bL3-vDNwM6uSMRGnbyY2UA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-407558fe418so52593215e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697715625; x=1698320425;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Cy+4LW6+tEFG7oSWEYyib070mePeApvTeuWzcQgmqk=;
 b=B56ncimlOlwvum2q6IUzvBDS5YAZnF+iZQLSBECPkvNOEj9oXFqhVb5jKA+dchGLQr
 iirJPkrdCG1mDuyBD0jIEQ1QuIVLjey3LwbLKsEpi6/YRGFnq7xHouKlML/F7dNSRnT6
 VjjVswETzVuGLxhfETgmmyiwcIgSjlfzSEolOxgfhw93SRH0CuDXrI87pEeLBxqhBjKy
 1paUAI/xbgdcekplJnSwL02JWfI5AKFfUdG5Tdjz7XXAINthDb85SqdXZiQByDLJLVYX
 8idbCoSxtnmXeC7QUQagyc0wPHiI0/aA4KacoxxhTi49RmcNDqpWiAV0AfQ8/uqu/7ei
 i7Iw==
X-Gm-Message-State: AOJu0YzyTiVN0nJnakeYkQXBKosP/YpvSwjg4qZ8QA5DyPs0E5LW345y
 gdvIg/fh0EuHrFailrPGSmEwhkeTZCEZc2cjcjIRCsvrSMVO5ko0/T4FBcZ2ulxe7CiWPMhKKrk
 Aghk/fcZkBMx5bUw=
X-Received: by 2002:a05:600c:1709:b0:3fc:dd9:91fd with SMTP id
 c9-20020a05600c170900b003fc0dd991fdmr1565020wmn.40.1697715625251; 
 Thu, 19 Oct 2023 04:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWYrp4FnkSDtJ6h9+q2f2fYV6/fXq3eMCtxvg62PHi4c9k29mx1oGF1H+ddX+a4PPJctK7Vw==
X-Received: by 2002:a05:600c:1709:b0:3fc:dd9:91fd with SMTP id
 c9-20020a05600c170900b003fc0dd991fdmr1565007wmn.40.1697715624928; 
 Thu, 19 Oct 2023 04:40:24 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bg14-20020a05600c3c8e00b00401e32b25adsm4361535wmb.4.2023.10.19.04.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:40:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org,  nanhai.zou@intel.com
Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
In-Reply-To: <20231018221224.599065-1-yuan1.liu@intel.com> (Yuan Liu's message
 of "Thu, 19 Oct 2023 06:12:19 +0800")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:40:23 +0200
Message-ID: <87cyxa6dso.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Yuan Liu <yuan1.liu@intel.com> wrote:
> Hi,
>
> I am writing to submit a code change aimed at enhancing live migration
> acceleration by leveraging the compression capability of the Intel
> In-Memory Analytics Accelerator (IAA).
>
> Enabling compression functionality during the live migration process can
> enhance performance, thereby reducing downtime and network bandwidth
> requirements. However, this improvement comes at the cost of additional
> CPU resources, posing a challenge for cloud service providers in terms of
> resource allocation. To address this challenge, I have focused on offloading
> the compression overhead to the IAA hardware, resulting in performance gains.
>
> The implementation of the IAA (de)compression code is based on Intel Query
> Processing Library (QPL), an open-source software project designed for
> IAA high-level software programming.
>
> Best regards,
> Yuan Liu

After reviewing the patches:

- why are you doing this on top of old compression code, that is
  obsolete, deprecated and buggy

- why are you not doing it on top of multifd.

You just need to add another compression method on top of multifd.
See how it was done for zstd:

commit 87dc6f5f665f581923536a1346220c7dcebe5105
Author: Juan Quintela <quintela@redhat.com>
Date:   Fri Dec 13 13:47:14 2019 +0100

    multifd: Add zstd compression multifd support
    
    Signed-off-by: Juan Quintela <quintela@redhat.com>
    Acked-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


You will get 512KB buffers to compress, and it could be faster.
The way it is done today, every channel waits for its compression.  But
you could do a list of pending requests and be asynchronous there.

Later, Juan.


