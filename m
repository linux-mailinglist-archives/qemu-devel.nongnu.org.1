Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABE970D626
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Mrj-0001Hg-M4; Tue, 23 May 2023 03:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1Mrh-0001H8-TT
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1Mrd-0000FV-Lr
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684828524;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9Ocid5oRiESpMpDgbHdzT6BFqbcw+/0XIQ/47UlT7NI=;
 b=AiHE7ghRCNxrjy5vKWpgaY4gByztVkXqCWqYMtlA0tX8JANhQxunGi6M1wQpuPywUJ0Qs9
 iEZ9olo28SK+EfPsbDbQ/QrXUY9y1p/cQb+hPhHbWJCTQkH6KHcnvpCijPWk/Q2OE8429P
 pesF1oFrhbQ7oxsrwc79zAY7LYT64l4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-M5FasW4EMWacnjbJMI-Fhw-1; Tue, 23 May 2023 03:55:22 -0400
X-MC-Unique: M5FasW4EMWacnjbJMI-Fhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18D431C0514E;
 Tue, 23 May 2023 07:55:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D13F8162;
 Tue, 23 May 2023 07:55:21 +0000 (UTC)
Date: Tue, 23 May 2023 08:55:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Camilla Conte <cconte@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: Add CI configuration for Kubernetes
Message-ID: <ZGxxZ6M7FRse47ox@redhat.com>
References: <20230522174153.46801-1-cconte@redhat.com>
 <d08d55dd-f38b-063c-d64e-9a0f79dbebf9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d08d55dd-f38b-063c-d64e-9a0f79dbebf9@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, May 22, 2023 at 03:52:30PM -0700, Richard Henderson wrote:
> On 5/22/23 10:41, Camilla Conte wrote:
> > Here's a second version (v2) of patches to support the Kubernetes runner for Gitlab CI.
> > You can find the v1 thread here: https://lore.kernel.org/qemu-devel/20230407145252.32955-1-cconte@redhat.com/.
> 
> 
> This does not work:
> 
> https://gitlab.com/qemu-project/qemu/-/pipelines/875254290
> 
> In particular, most jobs spent 30 minutes (until I cancelled them), e.g.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4329346855#L7561
> 
> Client:
>  Debug Mode: false
> Server:
> ERROR: Cannot connect to the Docker daemon at unix:///var/run/docker.sock.
> Is the docker daemon running?

Seems the problem is with the launcher for the k8s runner which throws
a mass of warnings & errors earlier in the logs about pods not being
ready

  https://gitlab.com/qemu-project/qemu/-/jobs/4329346855#L12

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


