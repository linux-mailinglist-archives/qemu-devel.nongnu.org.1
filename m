Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FBC7B84BA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:17:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4Y6-0007HL-9g; Wed, 04 Oct 2023 12:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo4Y1-0007Gz-RE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo4Xz-0002ql-2K
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XRel4v96xs2j5ayXmJxWAXFjXER1IgxJR9hXycgULlU=;
 b=NCtFGRPpIXRwIyVMtvIzjZ5wGNhWvDHQMBb/IJNH9c2D3STm7NIWgdUIfxktTvPA0Xto+8
 s3htrNgTxXRoad1+reSCe4aMGEIXsdEwGJ2JTI3j81l+1wpyZ8jbT93bFhheCIurXJG2e3
 JBV3x7ZEo6FaIOLC+iQWki6kM/adn3k=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-XS2UbIGANFOeG3TKHEK9vA-1; Wed, 04 Oct 2023 12:16:24 -0400
X-MC-Unique: XS2UbIGANFOeG3TKHEK9vA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1d664a00910so242583fac.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436183; x=1697040983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRel4v96xs2j5ayXmJxWAXFjXER1IgxJR9hXycgULlU=;
 b=afYtcMfRa0wj/ziTzKajo6UT87Mw2aXx+yNl7HqhlaYKjHve6QrVarQzVyw+ZO0gQm
 ZC3kwE6wLVynqXNNkGy5DwyJNJigsSkHkJUBEQiPFaDZTkNYULEKh8yxT02OqxQWOua/
 vVGzn+XTASuvlJZRbMmebQrQisbTeFvwe89h9O1A96SVRVSMcfoZnluWjZe11htn6heh
 IdQZSpjQllGhrQeuApZJy+dxWycWx/nD4/L24bBZyPBqueEjtVFyCfT8rCprLgFYI9YA
 5nRk6ChT//1oVk7UH2pwYrluU37Qvp8CAqBev3Oo7UttGoqwypomK1EKWH7N+TaQaun7
 0g7Q==
X-Gm-Message-State: AOJu0YywTs9bWJ+0QUHSfz4kSff/9Xo4h+ukd/aFH0YHSnbNIrxd6jgI
 rpBtxcvEAxIAKg8DfThhAsBw8EB34EA5nM93hC35UI3Im3cJ4mgGWVRcwpwqz3G9iBZmkLyfzgd
 DCXLtZ9f3/lQywzI=
X-Received: by 2002:a05:6870:509:b0:1bf:9fa2:bfa3 with SMTP id
 j9-20020a056870050900b001bf9fa2bfa3mr2830775oao.1.1696436183345; 
 Wed, 04 Oct 2023 09:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMEUJyLuFghhU4KLyEJB0fdsiuIjpaP0Cmk5l52liMF6iPn4LKpUfdfEIFzubIpjZm6oGqaw==
X-Received: by 2002:a05:6870:509:b0:1bf:9fa2:bfa3 with SMTP id
 j9-20020a056870050900b001bf9fa2bfa3mr2830749oao.1.1696436183028; 
 Wed, 04 Oct 2023 09:16:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 q19-20020a0cf5d3000000b0065afe8f149asm1430393qvm.69.2023.10.04.09.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:16:22 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:16:21 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/5] RFC: migration: check required subsections are
 loaded, once
Message-ID: <ZR2P1RbxCfBdYBaQ@x1n>
References: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
 <20230926155925.1396309-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926155925.1396309-5-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 26, 2023 at 07:59:24PM +0400, marcandre.lureau@redhat.com wrote:
> @@ -484,6 +513,13 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>          }
>      }
>  
> +    for (i = 0; i < n; i++) {
> +        if (!visited[i] && vmstate_save_needed(vmsd->subsections[i], opaque)) {
> +            trace_vmstate_subsection_load_bad(vmsd->name, vmsd->subsections[i]->name, "(not visited)");
> +            return -ENOENT;
> +        }
> +    }

One thing that might be tricky to call needed() on loading side is, IMHO
the needed() hooks normally was designed to be only called on a complete VM
state. IOW, I think it can reference any machine/device state, or whatever
variable assuming all of them contain valid data.

But the load side may not yet contain everything..  we can guarantee here
we loaded the full device state of this one as subsections should be the
last to come, and all we've loaded so far.  But what if it references
something else outside what we've loaded?  It looks possible in some
special .needed() hook we can return something unexpected.

I assume most needed() hooks are fine (and it does look like we can find
bugs with this, which means this might be proved useful already at least in
some form or another). I just worry on something start to break after we
become strict on this.

Maybe.. make the check only throw warnings, but not yet fail the migration?

> +
>      trace_vmstate_subsection_load_good(vmsd->name);
>      return 0;
>  }
> -- 
> 2.41.0
> 

-- 
Peter Xu


