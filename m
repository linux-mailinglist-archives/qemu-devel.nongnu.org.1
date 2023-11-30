Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3127FFE50
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 23:05:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8p8j-0002DL-2K; Thu, 30 Nov 2023 17:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8p8d-0002D8-Nh
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 17:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r8p8a-0005Lp-Oo
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 17:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701381837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCpjA53/kTeQg/7UUW/WQlWNZF7QqrHttxsPv22zU/k=;
 b=InViTtUKwCtADAK0BAz2i8bL38IJtG3Ofbeeb6Lw4lawucl8e73okVBHXCsuJaAWveXNdc
 SUV27owVymEUrfzmzyaCGjJKWc/3JUSVknYzSxhWRNFyhNM56Rk31UDTEMIln19Zr3D76L
 T3FddsStVdTE15FLaIqnbBVZ/UPAH24=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-y8mimw0yPEa-XRXdCNWPhw-1; Thu, 30 Nov 2023 17:03:56 -0500
X-MC-Unique: y8mimw0yPEa-XRXdCNWPhw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77d98b1df76so33471285a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 14:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701381835; x=1701986635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCpjA53/kTeQg/7UUW/WQlWNZF7QqrHttxsPv22zU/k=;
 b=QUR5+9v0qKNnvdEtWdCZMURJGveA7qFsZkMTf2rgj/Tl3VvhOcUB4EbeLMXgDIGLO/
 6KGcbacq4ATE2H9sRA0VAHe9xpCjpUz2/RBult1FFpRtCl13z0OfPikXmgYS0+qOLiKG
 TRMxqYKbHZp6b9Q47hFIWu4aZK1kIH1TXm0CY39p/joVb14kyLUApMf1V+Bg2OLDGOet
 cNBTENN//GopG9LNrTca9RbT81CRssI+1nfFKTTFKXp8xifTy2z7SwMjn9P/hQln9nfa
 cqmCyhBO2o9pGoHEl12LGcPa9c8OxTMrH34iLstkC2yERczRKX2ib+JxJCzX/tcNsMxx
 kw+A==
X-Gm-Message-State: AOJu0Yz4cPsvyaHCU92VvjKMSEG2hnc685uAMzMJ7z8fPcmuIufAwPiD
 2Y7bncrou++j9oZYiX8L1m16y/hLH7Hom9ccd6M0bv2tEwlyLppY+M44otzhTO3S+u9KmdEcEHV
 xrZ1LjljgIxznZ8s=
X-Received: by 2002:a05:620a:d89:b0:778:96e8:90af with SMTP id
 q9-20020a05620a0d8900b0077896e890afmr23833059qkl.5.1701381835754; 
 Thu, 30 Nov 2023 14:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvpEFfnA5j4DQkAWZ4nY4VeO1bEd02pcZNldnztL3f2ltQYPEYHbhNJ8UfVdqlnY+5hkLMyg==
X-Received: by 2002:a05:620a:d89:b0:778:96e8:90af with SMTP id
 q9-20020a05620a0d8900b0077896e890afmr23833038qkl.5.1701381835430; 
 Thu, 30 Nov 2023 14:03:55 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 i17-20020a05620a405100b0077dc299f44esm869636qko.51.2023.11.30.14.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 14:03:55 -0800 (PST)
Date: Thu, 30 Nov 2023 17:03:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 02/14] cpus: vm_was_suspended
Message-ID: <ZWkGyVgCloVcKL2T@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701380247-340457-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Nov 30, 2023 at 01:37:15PM -0800, Steve Sistare wrote:
> Add a state variable to remember if a vm previously transitioned into a
> suspended state.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I'd even consider squashing this small patch into the next, the reasoning
to have it resides there, but not a huge deal:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


