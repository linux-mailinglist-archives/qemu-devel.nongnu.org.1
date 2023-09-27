Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B901E7B0A18
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 18:27:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlXMq-0004Gm-37; Wed, 27 Sep 2023 12:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlXMo-0004G6-2N
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlXMm-0003pP-Oh
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 12:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695831984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZdPX9JB09/m2giIE8kvoctgntpKMruJ1Fx72wKND2Y=;
 b=OTKLiVcghVbFzGIyabOoYlZV8glIfUefNF7QeT7DfswJ40hbE5HQ5SDlvvBOFnTp/wk92u
 yMS7YeYwYkjDb251EC8Xos0xhzIW3tImaM7bzF+Lefyt6+WAkYruFPkpo2GiyO9c7dAx1f
 p1s9M1/AUOrW0wdu5YzUbm6MQFo2Wbo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-qidjIf8RM6u1mee8VP95pQ-1; Wed, 27 Sep 2023 12:26:21 -0400
X-MC-Unique: qidjIf8RM6u1mee8VP95pQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-655bc5ee855so39192056d6.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 09:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695831981; x=1696436781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZdPX9JB09/m2giIE8kvoctgntpKMruJ1Fx72wKND2Y=;
 b=DeSFI4qInA2MkJ1kuARkVzqC6wnUAJpSMmgsGpUyHqk3S8Ht9cbK3RHCZddIES+DN5
 0Y06j24xuCIsDuvrfDBDIwy9Tbbu4J6dXIxbt0gvVsNfXULE8RW/qmzeQ0my0ndPOMpY
 MYo1J5LW76JAvrHMqX1NicUqpTfn3De0p8UKlDk6D0mf9OMjycG2CjY5SS+rBc3EZ4fu
 IxsLAqXzRIWWZ6IJFvpzHX/heOAjX1jT+0d/u23Y66nQuTCsfxks6aXgarmHG6kzMmnl
 H09W/6CIGo84Ub+AjC/gRN7CeJlKWOoMOLye/ntv6+f8zdPOQdh97claROZF6FPZaSEb
 hvpg==
X-Gm-Message-State: AOJu0YzWZwwp22yL11iJkKnJEMb4wlz4NsJru3lzNO9OvgfSjlvPIXso
 k1E1uk0JQ4dgV/fTgnY7twNvBnvWntfs1lTydPuZNA4LJ11NMDNO6y50qNLVLx+eMV1oDJ5/rPG
 hOdN4Qig2/qw92/k=
X-Received: by 2002:a05:6214:411c:b0:65a:fd40:b79 with SMTP id
 kc28-20020a056214411c00b0065afd400b79mr2588351qvb.5.1695831981030; 
 Wed, 27 Sep 2023 09:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFePDNMm+R7YNQ/4tL4TuPH6YFwGY0iI8eDZuBYpYfyS5svOU8YfZ6pU2gbqbUNPc8dnYJGUg==
X-Received: by 2002:a05:6214:411c:b0:65a:fd40:b79 with SMTP id
 kc28-20020a056214411c00b0065afd400b79mr2588342qvb.5.1695831980772; 
 Wed, 27 Sep 2023 09:26:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e6-20020a0caa46000000b0064f378f89a7sm6038482qvb.73.2023.09.27.09.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 09:26:20 -0700 (PDT)
Date: Wed, 27 Sep 2023 12:26:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a migration reviewer
Message-ID: <ZRRXqYueA12R7zLf@x1n>
References: <20230927161138.30361-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927161138.30361-1-farosas@suse.de>
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

On Wed, Sep 27, 2023 at 01:11:38PM -0300, Fabiano Rosas wrote:
> I've been dedicating time to reviewing migration patches already for a
> while. I'll continue to do so for the foreseeable future.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu


