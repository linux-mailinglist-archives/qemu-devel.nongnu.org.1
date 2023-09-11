Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DE579AA20
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 18:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfjlz-000386-VW; Mon, 11 Sep 2023 12:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qfjly-00037v-EJ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 12:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qfjlv-0007Jj-Ph
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 12:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694449702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7uFlsERwDmRT8O6iEb35XZEPjfvNABm3CHBFvWi0sbc=;
 b=Kr2/GEbrbTRWD/MxvU0BxB8uJEdMcAweZL3eqFeJk8m2G7F6FfWSYDltVld71QT44r1Qw8
 yyTZtuZtWvxZfO/xDfvkDOzGrAqspk0T/He5YmYc3SgIDdZC+jfp+oLvep2DB9gWbJj0z7
 U7gwNlo24hhU7KzKKeX2maFk1KMauec=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9vtDQ54xONKmzQ-iCSkKDg-1; Mon, 11 Sep 2023 12:28:21 -0400
X-MC-Unique: 9vtDQ54xONKmzQ-iCSkKDg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3ab436c1438so1074620b6e.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 09:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694449700; x=1695054500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uFlsERwDmRT8O6iEb35XZEPjfvNABm3CHBFvWi0sbc=;
 b=lSm+GqsThc7JKK0O0hGX+YOV4E0s68Zd2zLgx0s8ksbM5CgbTjch+hzO8jDiwkDXdl
 vY2QzpHAa1PR9NHqCBqdFPievo5CuOp0HGmtSDljpFa9WK765G7XuJYvLHa6SxusMv86
 eZoJoOW+n/rHZ+56YGqA63lumfBN8mpCV01MaZZwV1mV/pnCqqUmqsGWe99HbiZ7oN1p
 fT2ury3eC2ZF/vcJwOyDoBIjfER1/Wb1H7HBWb7S4PhRQ6YWsHAZjFGxYHyP+GtCnC3q
 bUgz6wFTTBsbmbM9vEfgvLY6YNt4oVyqQsUXEsiVTeyzkxobUe5JOccod0t22PlMz35Q
 BVBg==
X-Gm-Message-State: AOJu0YwDk1rt6/YdUkp2PCUvABk333LRlrRn4SXzCU3wTGAL95KNmbor
 1ZQU7ybTpDdwry/qVOoviJyX97cE770/XY+J0l+h9+0s0sviZZTKsvRetvOIDwoJNlWREzzFVcJ
 fOwIlH7UJDggGLAc=
X-Received: by 2002:a05:6808:328e:b0:3a7:2eb4:ce04 with SMTP id
 cg14-20020a056808328e00b003a72eb4ce04mr8323439oib.5.1694449700629; 
 Mon, 11 Sep 2023 09:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDvKOAXnzWlENGB7NiEeVFA54B6llSlEJh4LJJPEZgsCmjR2UCSOT5EM97h+nDWTv3Qwzyzw==
X-Received: by 2002:a05:6808:328e:b0:3a7:2eb4:ce04 with SMTP id
 cg14-20020a056808328e00b003a72eb4ce04mr8323426oib.5.1694449700354; 
 Mon, 11 Sep 2023 09:28:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h5-20020ac87145000000b00407ffb2c24dsm2677697qtp.63.2023.09.11.09.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 09:28:19 -0700 (PDT)
Date: Mon, 11 Sep 2023 12:28:17 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmainquan <hongmianquan@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH v2,1/1] memory: avoid updating ioeventfds for some
 address_space
Message-ID: <ZP9AIScw8GrKZNlR@x1n>
References: <20230830032906.12488-1-hongmianquan@bytedance.com>
 <499fe9b1-54f5-4d0f-ae2b-165cb0f3e6b3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <499fe9b1-54f5-4d0f-ae2b-165cb0f3e6b3@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 04, 2023 at 08:51:43PM +0800, hongmainquan wrote:
> 
> Friendly ping...
> Hello, this patch has already received a R-b from PeterXu. Could you please
> help me review it as well and see if there are any issues? If everything is
> fine, could you please consider merging it? Thank you!

Paolo, wanna pick this one up?

David, I know you're preparing a pull with a lot of memory changes, if you
like to pick this up it'll be good too.

If no one will pick it up, I can try to send a pull just to have this
patch, as long as it will work out.

Thanks,

-- 
Peter Xu


