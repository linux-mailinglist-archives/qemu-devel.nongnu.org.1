Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C86117D5681
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJOY-0005Cr-GB; Tue, 24 Oct 2023 11:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvJOO-0005BZ-Bq
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvJO9-0005R9-Rh
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698161532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0tmDXoXnPAyoOlsCmRkLk3j0biBW+2kr+WCVmlhFlI=;
 b=bei8sMExXjpcSyaVz0aBH8VPRPgLuWBgXpMYfRkHUkp68G4Rc5oJ8CRHgTYSaOPoR1C4T+
 k8mESC9qhv9yNjf7FCq7OSevwM+1FqPIHUvJCBfnTXtRaMegFUZtKgdcZogGKbIQq0bopm
 sRWa6a4B6Cn+FrcaoJ0EPwG2Qxbrsds=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-uq6m-aokOvW2Wa9ZP_zOiw-1; Tue, 24 Oct 2023 11:32:10 -0400
X-MC-Unique: uq6m-aokOvW2Wa9ZP_zOiw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-778a3e0b755so106531185a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161530; x=1698766330;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0tmDXoXnPAyoOlsCmRkLk3j0biBW+2kr+WCVmlhFlI=;
 b=jxkjVdDTo9ZB70JDw9BYMjuaVJO+5nUvR2rPOHjjE1VomuIShG9Qpk26PfqbnFmYaa
 M4SfXSrLMX2s6x0SiQodfJxqKA6DjtOXN4gcEHT3CO+0LCT59piw1w8dkoUoDWzCZeEQ
 hVs76z+HVtRco54fpkYaEQ1hK60elK3NkzF/kCHkMh2xZS6WL8HtLQNiOzds3NC7R7Nb
 T0gS5LUHFXm6IzGaNq1qzZHsNRDmn60njSUnlC/VUl9cLtCaLlICXHan3+Eo8M8dUcj1
 U5aqgs4bjSATAau4IC3bq1Ol3oJe8F/5OqnJQOvw/XbnJLXueHffO9DHQQ/wcknCL9AP
 XEgg==
X-Gm-Message-State: AOJu0YzDf6h0jmNDDXvDjKLIVg69O4nN2gup7hob+QHg6m9tcBanwJDS
 5Bhyp9Y+TzLXLjWpm1InQmWNUC1C6PcKC9dKWU//1DZNbB7OHElU5lw5P0lu65LordBKiPSvy77
 gFWpV08LdTrI8QOQ=
X-Received: by 2002:a05:620a:6182:b0:767:e04f:48c8 with SMTP id
 or2-20020a05620a618200b00767e04f48c8mr11640642qkn.7.1698161530054; 
 Tue, 24 Oct 2023 08:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHATydneQ54okK/qL/5+6mH5GliSTXGMMy+OGxz4VPhHaigiVhqX6Y+xbrlQfGOZQ9O2zMTfQ==
X-Received: by 2002:a05:620a:6182:b0:767:e04f:48c8 with SMTP id
 or2-20020a05620a618200b00767e04f48c8mr11640625qkn.7.1698161529698; 
 Tue, 24 Oct 2023 08:32:09 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j17-20020a05620a001100b0077703f31496sm3517315qki.92.2023.10.24.08.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:32:09 -0700 (PDT)
Date: Tue, 24 Oct 2023 11:32:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 1/1] migration: vmstate_register() check that
 instance_id is valid
Message-ID: <ZTfjd3AFVFaMiAqm@x1n>
References: <20231024150336.89632-1-quintela@redhat.com>
 <20231024150336.89632-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024150336.89632-2-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 24, 2023 at 05:03:36PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/vmstate.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 9821918631..c48cd8bb68 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -28,6 +28,7 @@
>  #define QEMU_VMSTATE_H
>  
>  #include "hw/vmstate-if.h"
> +#include "qemu/error-report.h"
>  
>  typedef struct VMStateInfo VMStateInfo;
>  typedef struct VMStateField VMStateField;
> @@ -1226,6 +1227,11 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
>                                     const VMStateDescription *vmsd,
>                                     void *opaque)
>  {
> +    if (instance_id == VMSTATE_INSTANCE_ID_ANY) {
> +        error_report("vmstate_register: Invalid device: %s instance_id: %d",
> +                     vmsd->name, instance_id);
> +        return -1;
> +    }
>      return vmstate_register_with_alias_id(obj, instance_id, vmsd,
>                                            opaque, -1, 0, NULL);
>  }

Juan, could you remind me what's the benefit of failing it like that?

IIUC you want to suggest using vmstate_register_any(), but I think it's all
fine to do vmstate_register(VMSTATE_INSTANCE_ID_ANY)?  You didn't have a
commit message, so I am guessing..

Even if that is wanted, the current error message can be confusing to a
developer adding a new vmstate_register(VMSTATE_INSTANCE_ID_ANY) call.
Maybe directly suggest vmstate_register_any() in the error message?  But
again, I don't see a benefit, vmstate_register(VMSTATE_INSTANCE_ID_ANY)
should still work if without this patch?  Where did I miss?

Thanks,

-- 
Peter Xu


