Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6F71278B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 15:32:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2XXn-0001Hc-8J; Fri, 26 May 2023 09:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q2XXk-0001Co-Kc
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q2XXi-0002fX-UC
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685107901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mifFd4DOIa2yhbn68ymDoE3MCHEMItUB2TWSqQmG0AY=;
 b=O1F8Gv+4PIB2LneN/ot390Kl5PoxCMe3JmKkrEiLoHWsbTWz9sAOLtt6c7M0piYNyeG0mb
 tJZ98bEodftr+UL7Gxiagto+0RiMRVp3jaz2S0GnOTji153sT8TEYG6tzQcS6/4xgmSvBE
 S/F3Y1P4TWOWUOX8BvostVjCsZ2gDvY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-OVHrdDX4Nd2OrMbv7EMS_A-1; Fri, 26 May 2023 09:31:39 -0400
X-MC-Unique: OVHrdDX4Nd2OrMbv7EMS_A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso70775966b.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 06:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685107898; x=1687699898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mifFd4DOIa2yhbn68ymDoE3MCHEMItUB2TWSqQmG0AY=;
 b=PGsflO44jBvyguusR7lAD31aFPSV7aOCEdXklWfm8vjoI4SKCUG0N7qebbrZPlXEbX
 fSez4NMEU/dkI4lNuT7+LO7gFRewbe5WeiGWG6rqbvQYZTMXV1LI/8uyj1o5LuYsQAub
 HtJ5tUiuzKHuyVlFJjb+df72QUJ9SSwwSgb2n9ZP8kjzivzPJJedy0/I5Vd0rMRhWz2p
 W6vMeXNobL1XFsalmKYwdbPQSzaUTclisLwF/OeepgJF/uGgvIwN1Rf5Fp5EW+YUFkHq
 dSAKpEDOirO5O9GE6+eUwfptUkk2rfS7t6nhlc3Mcu6+cz/Z+NO5A+I4f0CmHqmG+Fk9
 NYWg==
X-Gm-Message-State: AC+VfDxDKTI5h9Y3T9BZ3QyIrzb0Hw9PijLBzM5VFTDtnTCKomjwcavr
 ZbwVxXMvSeuOAoejfv0cxBcv1gkBwDvA/SUfMxi+3OH0z0RIQXtFo83eW4c68UwD6+6t+WwFLBO
 pjIt/abhMVu3n4JM=
X-Received: by 2002:a17:907:36ce:b0:973:a3f4:c87b with SMTP id
 bj14-20020a17090736ce00b00973a3f4c87bmr2085141ejc.50.1685107898252; 
 Fri, 26 May 2023 06:31:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Exs7OdIa2hbOIRAYaJOGbxib+J47J8vtqfKcX1hl7BHGL3QkyFpm3HUGUqrf7h1vBvVJn9w==
X-Received: by 2002:a17:907:36ce:b0:973:a3f4:c87b with SMTP id
 bj14-20020a17090736ce00b00973a3f4c87bmr2085120ejc.50.1685107897835; 
 Fri, 26 May 2023 06:31:37 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a1709060e1200b0094f7744d135sm2149304eji.78.2023.05.26.06.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 06:31:37 -0700 (PDT)
Message-ID: <592e1caf-851a-7af0-2182-b70a62b6f826@redhat.com>
Date: Fri, 26 May 2023 15:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] qcow2: add discard-no-unref option
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20230515073644.166677-1-jean-louis@dupond.be>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230515073644.166677-1-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15.05.23 09:36, Jean-Louis Dupond wrote:
> When we for example have a sparse qcow2 image and discard: unmap is enabled,
> there can be a lot of fragmentation in the image after some time. Surely on VM's
> that do a lot of writes/deletes.
> This causes the qcow2 image to grow even over 110% of its virtual size,
> because the free gaps in the image get to small to allocate new
> continuous clusters. So it allocates new space as the end of the image.
>
> Disabling discard is not an option, as discard is needed to keep the
> incremental backup size as low as possible. Without discard, the
> incremental backups would become large, as qemu thinks it's just dirty
> blocks but it doesn't know the blocks are empty/useless.
> So we need to avoid fragmentation but also 'empty' the useless blocks in
> the image to have a small incremental backup.
>
> Next to that we also want to send the discards futher down the stack, so
> the underlying blocks are still discarded.
>
> Therefor we introduce a new qcow2 option "discard-no-unref". When
> setting this option to true (defaults to false), the discard requests
> will still be executed, but it will keep the offset of the cluster. And
> it will also pass the discard request further down the stack (if
> discard:unmap is enabled).
> This will avoid fragmentation and for example on a fully preallocated
> qcow2 image, this will make sure the image is perfectly continuous.

I don’t follow how this patch is cleaner than the “block: Add zeroes 
discard option” patch.  That patch’s diff stat is +14/-5, this one’s is 
120+/57-.

As for better, I don’t want to discount that, but at the same time I 
don’t know the reasoning for it.  As far as I understand, this patch 
makes qcow2 retain the cluster mapping as-is, and only discards on the 
lower layer.  So effectively, instead of marking the cluster as zero on 
the qcow2 level, we do so on the filesystem level.  I’m not sure I see 
all the implications of that difference.

The advantage I see is that this free up disk space, which the 
discard=zeroes wouldn’t do.  I wonder whether that couldn’t be solved 
with an orthogonal qcow2-only option, though, which would have the qcow2 
driver always discard zeroed clusters.

On the other hand, one thing to note is that we’ve had performance 
problems in the past with holes in the filesystem level (on tmpfs at 
least).  qemu generally can get the information on which clusters are 
zero quicker from qcow2 than from the filesystem, which suggests that 
even if we want to discard something on the filesystem layer, we 
probably also want to mark it as zero on the qcow2 layer.

I also have a small concern about fragmentation on the filesystem layer 
– if you use these options to prevent fragmentation, with this patch, 
you’re only doing so on the qcow2 layer.  Because the cluster is then 
discarded in the filesystem, it’s possible to get fragmentation there, 
which might not be desirable.  I don’t think that’s too important, but I 
think it’d just be nice to have a configuration in which the guest can 
tell qemu what areas it doesn’t care about, qemu marks these as zero, so 
that backups are more efficient; but at the same time, everything stays 
allocated, so no fragmentatoin is introduced.

Hanna


