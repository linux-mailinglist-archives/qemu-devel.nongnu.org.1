Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5DB77E41F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:50:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHp6-0004Tj-Gz; Wed, 16 Aug 2023 10:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWHp2-0004TV-9p
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWHoz-0000Sv-UT
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692197308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ujo6KeUqyKMMgxt2qNY2x+TBGFyJfNw1cmYrZsT0Z88=;
 b=JpxXwbViMVm275ejL3gwyioeXsiVC5+LFGF+kWPoMz52zuLNcJkA028hFfCI2IQVfC782p
 mWVXCL0ou45ZS0EHJS+OaNZRehcgL3nZrteXwJ9Z6FpQXN3/GGeSkQtnA6XbNXXEl964kf
 BEJLCM3bhx1BsVBtfNI05mib/uw5OtI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-sviLiKqVNHa763J_Yu72Gg-1; Wed, 16 Aug 2023 10:48:27 -0400
X-MC-Unique: sviLiKqVNHa763J_Yu72Gg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76c7cffef41so176128985a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692197306; x=1692802106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ujo6KeUqyKMMgxt2qNY2x+TBGFyJfNw1cmYrZsT0Z88=;
 b=HCswSmPp73N8gn40mP3/Zs7TEAFCKKrBWy7qdITH3oKG1luIMs+DsCoAe8A5O8nH9A
 w4avAaImEDPkeS+ZL+MzjQklyrPpPnfs1DuKnIbtFg1DcoQesyQ4kO3k0AImHNd6P/hT
 6dZZdIVLg0oQPhBpaV1teb5o6cRzxbfhvUHsDSpFq5Ansig5/T0ljL4b3lBcPM6at+0c
 xKcIy/93fJvtI630a5c8jz0JKUdbKmxtzB32JuJsNI9Uni99n4oFHWbPVRtmi9CV7V5W
 8JxemcW5N1gbhyV5OmIU9rac+pODAlwZtM+mfqKJfxxi/cewcl9l5jflJieV30o9zXNj
 B9PQ==
X-Gm-Message-State: AOJu0Yws/QY3cXgV75d/dFmdQ3GgJq588rhr02PXUbNXxyunhBYNield
 elSTIzserZEp8UBzreq2jjxZ/ULj8YfDPSci9W3IcOJlZTP2X4YDK2zQEKcVFOZKr41x0seUC1r
 7y9rbpAbIN24pf/k=
X-Received: by 2002:a05:620a:4093:b0:76c:ed4e:ac10 with SMTP id
 f19-20020a05620a409300b0076ced4eac10mr2807490qko.6.1692197306599; 
 Wed, 16 Aug 2023 07:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+BKXbtgH1XJPUB60Rv0I8pXREbzXvF55AH2rIyLlnnDkigtpMZZK7lfZSeNN8sLn7PnjRiw==
X-Received: by 2002:a05:620a:4093:b0:76c:ed4e:ac10 with SMTP id
 f19-20020a05620a409300b0076ced4eac10mr2807478qko.6.1692197306230; 
 Wed, 16 Aug 2023 07:48:26 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05620a16cb00b0076cdb0afbc4sm4502961qkn.118.2023.08.16.07.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:48:26 -0700 (PDT)
Date: Wed, 16 Aug 2023 10:48:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Guoyi Tu <tugy@chinatelecom.cn>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return if
 qemu file got error
Message-ID: <ZNzhuF7fRUdaGthV@x1n>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
 <87h6p0mqk8.fsf@suse.de> <ZNv6ABLk7EjaX8dD@x1n>
 <87350klygf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87350klygf.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Aug 15, 2023 at 07:42:24PM -0300, Fabiano Rosas wrote:
> Yep, I see that. I meant explicitly move the code into the loop. Feels a
> bit weird to check the QEMUFile for errors first thing inside the
> function when nothing around it should have touched the QEMUFile.

Valid point.  This reminded me that now we have one indirection into
->ram_save_target_page() which is a hook now.  Putting in the caller will
work for all hooks, even though they're not yet exist.

But since we don't have any other hooks yet, it'll be the same for now.

Acked-by: Peter Xu <peterx@redhat.com>

For the long term: there's one more reason to rework qemu_put_byte()/... to
return error codes.. Then things like save_normal_page() can simply already
return negatives when hit an error.

Fabiano - I see that you've done quite a few patches in reworking migration
code.  I had that for a long time in my todo, but if you're interested feel
free to look into it.

IIUC the idea is introducing another similar layer of API for qemufile (I'd
call it qemu_put_1|2|4|8(), or anything you can come up better with..) then
let migration to switch over to it, with retval reflecting errors.  Then we
should be able to drop this patch along with most of the explicit error
checks for the qemufile spread all over.

-- 
Peter Xu


