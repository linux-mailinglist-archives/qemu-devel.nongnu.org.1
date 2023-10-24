Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BD07D5C35
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 22:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvNk0-00041c-Fr; Tue, 24 Oct 2023 16:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvNjr-0003wT-AB
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 16:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvNjp-0002SW-Lp
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 16:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698178251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfKoy8FVV6PPF5RCF58eScIokA49NYws/3RTgMbnH2A=;
 b=CKzSTgucDjUpqck/cRBG38xdnOV9rLOHmKWixhhQlkY2M3xmhPBbn/PFX33HikQR1eJS7G
 IWfCP5R32UTVnmMJ3YFJz0UYI+522ymzu49s2nkMYhYly0nf2GLkGZSPCAjeZs//EQK/Co
 nihO178ub6R5VZ8utZGQcfvzflriBBE=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-VhHGQ7EkOvWXjKNESowOyA-1; Tue, 24 Oct 2023 16:10:49 -0400
X-MC-Unique: VhHGQ7EkOvWXjKNESowOyA-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-49cf3b3d9faso157138e0c.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 13:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698178249; x=1698783049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfKoy8FVV6PPF5RCF58eScIokA49NYws/3RTgMbnH2A=;
 b=VdPp7McI3Zyp7wJJdgL4Dxbkf5UUgdePqZ1EfUoly1iiEUY1+LitrTQVJXt+xsqnPb
 MA6aa+3CEGugRNxzs6Fz8fUj3gVNxTgfwc7wxzvxdQ1DcSM8GJ5H3cz5rpQVyFvfum+O
 mHV627RVNFQPynIpsIC91JIAXZpuGUu7Ut2vcXamsmHI+bjbFMcVAhw99BxETrUBZB4P
 HrC0q8wjN8fZCCTQnemsg/2HlB46RRL07YM/adI+hx2FHz4IMpjfAz14Q+jyD8CXB6DZ
 Luu4LHWKXsJ9glLrbUQYq/nir+DUArjwEx+XRlqwSi8ZlolNgjXuYugBjwdMcnoAZpCR
 C5zA==
X-Gm-Message-State: AOJu0YzpsoO337thTo15CeqF+C262gTF3Gn+xNR0KCnTtFZC+zTIgJBx
 FZxkoHo1R2HACxdi8ChmpR68Sd4lAtWB5ab/1NowIEqWQ4ijKFtcFcoX+o+Q73UYoQ8iE2ZZKgK
 vsHF3Ay9p+Zozgq8=
X-Received: by 2002:a05:6122:b71:b0:49a:c2d3:94ee with SMTP id
 h17-20020a0561220b7100b0049ac2d394eemr7172154vkf.0.1698178249219; 
 Tue, 24 Oct 2023 13:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQvOOXozuVdquG/vEp34C3tVZ9Pr6V/8ylmG7Cc/xclp6HCqnA/F2wINIRU+6nY0lU9k7woA==
X-Received: by 2002:a05:6122:b71:b0:49a:c2d3:94ee with SMTP id
 h17-20020a0561220b7100b0049ac2d394eemr7172140vkf.0.1698178248791; 
 Tue, 24 Oct 2023 13:10:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 br11-20020a05620a460b00b0077412ca0ae1sm3664750qkb.65.2023.10.24.13.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 13:10:48 -0700 (PDT)
Date: Tue, 24 Oct 2023 16:10:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 5/9] migration: check required subsections are loaded, 
 once
Message-ID: <ZTgkxrbemYtW9yK7@x1n>
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-6-marcandre.lureau@redhat.com>
 <875y2w1evf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875y2w1evf.fsf@secure.mitica>
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

On Tue, Oct 24, 2023 at 12:41:56PM +0200, Juan Quintela wrote:
> > @@ -509,6 +538,13 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> >          }
> >      }
> >  
> > +    for (i = 0; i < n; i++) {
> > +        if (!visited[i] && vmstate_section_needed(vmsd->subsections[i], opaque)) {
> > +            trace_vmstate_subsection_load_bad(vmsd->name, vmsd->subsections[i]->name, "(not visited)");
> > +            return -ENOENT;
> > +        }
> > +    }
> > +
> >      trace_vmstate_subsection_load_good(vmsd->name);
> >      return 0;
> >  }
> 
> This part is the only one where I can see there could be some
> discussion.  So I wil wait to see what other people think.

Previous email:

https://lore.kernel.org/qemu-devel/ZR2P1RbxCfBdYBaQ@x1n/

I still think it is safer to not fail unless justified that we won't hit
surprises in the ->needed().  There are a lot so I assume it's non-trivial
to justify.

We can switch the tracepoint into error_report() in that case, though, as
long as it won't fail the migration.

Thanks,

-- 
Peter Xu


