Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E237D512B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHDN-0003DH-2C; Tue, 24 Oct 2023 09:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvHDK-00038u-EY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvHDB-0000pq-KX
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lSYHlp+lBdot+o2CyIu3YVYYa2xQpaza1jnFgDU039A=;
 b=aV1C5Sls1whpdogZr9EHxdIpLazCqVgY3NCFCIeH3L1zzU3jfOI8piIsUGnMLPrYfQjsXp
 X3iPiKPcv4FfC5Z8BKRo529lgLyPSTAyYZeqAC37+OaMOumj5gJ0BVGNuX6JWZNtdH8xVE
 5DHpjU2S6X2mmiqluMF4KtgghgfcSVA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-jG2DXdShPFi9NX6tAQbyNA-1; Tue, 24 Oct 2023 09:12:41 -0400
X-MC-Unique: jG2DXdShPFi9NX6tAQbyNA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41e1d5557a9so5201841cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 06:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698153160; x=1698757960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSYHlp+lBdot+o2CyIu3YVYYa2xQpaza1jnFgDU039A=;
 b=Vt7TaL7c5YNe4J7ipnPPAyI1e2FAeZ53J/4M6K4vwqk325DoD8BB8ngOa7Rjf0Vten
 q0BZuGo+ZqluVaEOi/RKmSADxTy/sECb7mC2hfR1di3tM+udEp9vYnx/FpFX4BKRGYPe
 P/ZFRAv3QQ69HCKxcVhFrf3bo1YlHY5/+W2MRb8sxzeXrU9HW5hL9Ve2tL220UiY/yYP
 ZqLT+tcKdUSFB5rfNHPZF8N1NtFSNzZdrfg3oBrYywG2lLgQvmM0NLkTSTfnHOVPyDgB
 21jaT5mkDEcnK8CtGqsrV2Cy0zB/TWqsmbVjgCoPzqKpfCc3vxyjl6jF/Qp8deJ9lyAT
 SmmQ==
X-Gm-Message-State: AOJu0YzzI60szPjtvUmsJCxj+40vMoGRe3XgdAqQh7t5sxRaTfFVc091
 w6h2i7cJgKNlQUv6uD+oV4Q0em13lnySKUlSfjDJyqLOq57GgLCUyPBczSBZt0nw4cP3/Mc/J33
 S0SpcAEHrrI7WW50=
X-Received: by 2002:ac8:7f16:0:b0:41c:d528:6589 with SMTP id
 f22-20020ac87f16000000b0041cd5286589mr14726610qtk.4.1698153160506; 
 Tue, 24 Oct 2023 06:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEULBtXIToWxEnv6RK0cJpA9JJ/ebGED+3LQ+QLTzTjPHGLpg8IitgBB7Mu5lu6NK248uUZ2g==
X-Received: by 2002:ac8:7f16:0:b0:41c:d528:6589 with SMTP id
 f22-20020ac87f16000000b0041cd5286589mr14726597qtk.4.1698153160232; 
 Tue, 24 Oct 2023 06:12:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l12-20020ac8148c000000b004196a813639sm3465088qtj.17.2023.10.24.06.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 06:12:39 -0700 (PDT)
Date: Tue, 24 Oct 2023 09:12:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: ram_save_complete() is fishy
Message-ID: <ZTfCxf5+fHafbDRe@x1n>
References: <20231023145044.104866-1-thuth@redhat.com> <ZTaX00kf3UcQG/AF@x1n>
 <a326eafb-955b-4867-94f5-052672f93138@redhat.com>
 <75a76824-9b8e-45d3-a2ae-718295223715@redhat.com>
 <ZTbBuhMOUCwCs8Km@x1n>
 <d41c8909-25e7-40a6-8dcc-2c0094a56f13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d41c8909-25e7-40a6-8dcc-2c0094a56f13@redhat.com>
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

On Tue, Oct 24, 2023 at 11:05:12AM +0200, Thomas Huth wrote:
> Oh well, looking at the whole file, it seems like most spots that call a
> rdma_* function just do qemu_file_set_error() afterwards, but then continue
> with the normal workflow... that looks really confusing to me - if this
> needs fixing, it should be done by somebody who knows that code better than
> me, so I'll keep my hands of this and let somebody else fix it if necessary.
> I'll just respin my original patch to fix the -Wshadow issue.

Oh.. let me take a closer look today.  Thanks for helping, Thomas!

-- 
Peter Xu


