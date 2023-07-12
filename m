Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E47C750013
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:29:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUHL-0002Ol-Ll; Wed, 12 Jul 2023 03:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJUH7-0002MA-TY
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJUH6-0000zJ-FI
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689146915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xvK4HTLBwNIYDQlqUppsOq5aMRVvzlPzY1paTVdKXIE=;
 b=QwcRjKUda64GGx02zEJYh65wGoG5fzHaDChVuAe7cqd/KVVvyQRezuBWFNd0rX+SX2h+Sg
 i4SF12YFC3LhX7AYo3YM6HGtbnsuSDjNpvXDcqHBjX/kc2+0VTDimzNKywWk36X8KbzhOH
 BP9gqVs0Kz2k4W+AWzeaMFonXxNYuuI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-alkh7NEeMDy6E9bdJPCHDQ-1; Wed, 12 Jul 2023 03:27:54 -0400
X-MC-Unique: alkh7NEeMDy6E9bdJPCHDQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313e6020882so159874f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 00:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689146873; x=1691738873;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xvK4HTLBwNIYDQlqUppsOq5aMRVvzlPzY1paTVdKXIE=;
 b=bPexQ25e4NbtBkaDc8pVNLT3nXvuq3lDMhqYiwe484So9mLXeKQVvF+IujBYR6mjiR
 lmJeSsXFUyZhcOScW4qeTD3ApKF6sWInApNl+LR/vCmEyj4ExFbU8CJd7MCX68DFuAta
 sdtasTWeLUdM6zm//T6JYK8vFS86+2EILB3Z6tWXX9jXj3h4vEq2ONQFrjxyoq/gemmi
 gBOy7JkwMm05NlQDPf/mdUHE0qQuDddnfup3TvPInZSCQoi7XLkK4giIfQYtVox8QfSZ
 HnTVVQYrEx72P4l704J6wyxn5l7UhIgcQJWTdvT0rRpGMjFvE5jEBlhxOui+LweElaeY
 DrLg==
X-Gm-Message-State: ABy/qLZXpPe84FQXacIcNOve0ufmzOmSqL/HGJD8Y3NDsmPnVSzA+8ue
 8aY7fN+ikfq2yvmWCXsfpgCgHG2XYhgLvLnGTMz2ycwmNDmzFOWvBvitaI7rZ+fEwVcGvXqbbba
 vep6gyCU21sj5dFHUznnFqH1cFyV+tf+7O+mC30d3zZGFaWBPoHvQZ4zf4nDpogI5W3BIcec=
X-Received: by 2002:adf:f9c6:0:b0:313:f000:5de6 with SMTP id
 w6-20020adff9c6000000b00313f0005de6mr898466wrr.16.1689146873316; 
 Wed, 12 Jul 2023 00:27:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENnYG4gmE4DzKBJ8L+ZwXC+bpKnk5B4NyftwUeCHQPsxDVI5BIMsGB0tSBAuQEG22MO2KnPg==
X-Received: by 2002:adf:f9c6:0:b0:313:f000:5de6 with SMTP id
 w6-20020adff9c6000000b00313f0005de6mr898417wrr.16.1689146872886; 
 Wed, 12 Jul 2023 00:27:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3700:3eea:ace6:5bde:4478?
 (p200300cbc70737003eeaace65bde4478.dip0.t-ipconnect.de.
 [2003:cb:c707:3700:3eea:ace6:5bde:4478])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a1ccc19000000b003fbcf032c55sm14900674wmb.7.2023.07.12.00.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 00:27:52 -0700 (PDT)
Message-ID: <5be74bef-8a0d-af77-85eb-edbc07c8fff7@redhat.com>
Date: Wed, 12 Jul 2023 09:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/7] virtio-mem: Device unplug support
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230711153445.514112-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230711153445.514112-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 11.07.23 17:34, David Hildenbrand wrote:
> One limitation of virtio-mem is that we cannot currently unplug virtio-mem
> devices that have all memory unplugged from the VM.
> 
> Let's properly handle forced unplug (as can be triggered by the VM) and
> add support for ordinary unplug (requests) of virtio-mem devices that are
> in a compatible state (no legacy mode, no plugged memory, no plug request).
> 
> Briefly tested on both, x86_64 and aarch64.

Queued to

https://github.com/davidhildenbrand/qemu.git mem-next

-- 
Cheers,

David / dhildenb


