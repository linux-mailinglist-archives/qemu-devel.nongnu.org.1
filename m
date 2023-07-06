Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A25B74A3DE
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTt1-00084u-3M; Thu, 06 Jul 2023 14:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTsx-000832-E9
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTsv-0005Yy-TD
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688668760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hXWrEh+Cy6nbSk01Y+ceXGLVN04cETRNPWaKar3Iqi0=;
 b=ML3lTuNSA3C79XE8GcIgWljM6hGUcSm4G5dJf1I3LThU5NpBG727hKmvPXUkfzcCm4AzWL
 Jvq0JyB2bi7ha9apr9OQ60XVE59lUKHu0+QywY1L8XES8SbL69pU1R8QN7r4qWoosD25AU
 G/FQ52Ret12jilx9WVnSsC/kf43vfuo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-cNj1oPssP7-jbB4v9kMPZQ-1; Thu, 06 Jul 2023 14:39:17 -0400
X-MC-Unique: cNj1oPssP7-jbB4v9kMPZQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-765ad67e690so22338685a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688668757; x=1689273557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXWrEh+Cy6nbSk01Y+ceXGLVN04cETRNPWaKar3Iqi0=;
 b=LpSa58coKyglM+SbZLOEEvpkzPTMGZjExoW5x27abefBnIMR/az6A2AVubVGW3Oes/
 w1fwqT2YQMm5FkEW0sY7SodxY4semaXcy9iahZnQBDZ3YnRSLjiUSuvmYxnPizbuUnGH
 z7uSPvyLxvDprA/zEak0gnZup0S4/9ccxVweZDZJiTREdZZI11OhiChEJ2Z83uC47Qqg
 lWHI+x6flCxlJGFjFcuMxTDzDB0SQyFqAiy3CcAAn4lNBrsZJZd9ufflL9eTrLV8LX8c
 GY8B7Kb2A9HRn3pb8pFWBKrlkMn89Z/iyWvRjTZ+aFB5RHX8qScNr0rAcInI+y61eWJf
 RngA==
X-Gm-Message-State: ABy/qLZ33YoVMxSjZRA2lfi3wHfdewomwkcd4z8Zni/3Bl9thIL+YFtm
 gQZq+GhOFp43bjcUk564nHRKFmSsJhAE0x7Fug1kOEIepH+Ea13LZAH3UKhEUf8T3JP9ce/Py7+
 /JAHomP6phUTpZJ4=
X-Received: by 2002:a05:620a:290f:b0:767:ffb:58aa with SMTP id
 m15-20020a05620a290f00b007670ffb58aamr3515578qkp.3.1688668757038; 
 Thu, 06 Jul 2023 11:39:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHns7Tc+Rm41bylbTKcwT6nawLggCtkWNiS/DHd7aRgtei07JH42RMoZaJSPreOym4W0cl+xg==
X-Received: by 2002:a05:620a:290f:b0:767:ffb:58aa with SMTP id
 m15-20020a05620a290f00b007670ffb58aamr3515551qkp.3.1688668756695; 
 Thu, 06 Jul 2023 11:39:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 oo26-20020a05620a531a00b0076715ec99dbsm976950qkn.133.2023.07.06.11.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:39:16 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:39:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 1/6] tests/qtest: migration: Expose
 migrate_set_capability
Message-ID: <ZKcKUldUCPpA9tJL@x1n>
References: <20230630212902.19925-1-farosas@suse.de>
 <20230630212902.19925-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630212902.19925-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 30, 2023 at 06:28:57PM -0300, Fabiano Rosas wrote:
> The following patch will make use of this function from within
> migrate-helpers.c, so move it there.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


