Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E440708079
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:53:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcBo-0005We-Ii; Thu, 18 May 2023 07:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzcBi-0005Vl-Td
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzcBh-0005MX-GS
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684410771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3xU8untOOZBO7LFdSDKysjfFrI/j/4TlKPruEBh3zs0=;
 b=KRKegXf8kmkF9U4i5W8GCW+D3L97cMDdE2sKulI+Mv3mY7FNbOiW4ci7gKvKoH17Hza8hY
 RFGEjml0Qvr3Opvxcl86DQd0/QrHTWe67v1gbucUBXj+g1c11FArXwiRnUajRBR3YtY5mQ
 HuC0JvbX0PcrnWPJfcZrGNKZPQzlPSQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-D9SQnbP1PXyUPnG-D0PAww-1; Thu, 18 May 2023 07:52:50 -0400
X-MC-Unique: D9SQnbP1PXyUPnG-D0PAww-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f423d47945so7322975e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684410769; x=1687002769;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xU8untOOZBO7LFdSDKysjfFrI/j/4TlKPruEBh3zs0=;
 b=EjLaMPr+KEQrAuVHiFmcNNF6FmJemeN571Hk34kAAzJqdz6DMrJIPT3yjIkNv+QWr2
 fg8BWVxJe0c4+gvZai5ehUKyf/bjS3bC+1zsB5KtvXHFwU6H0cN/71l0UEP2YCJ6m0Qv
 hvvK3VpdiF0z2RJRNhTcBjBxIFkE7HfRazFyBnb12XF+YtzFrIPWG5ZuL7R9uZDTTn2N
 oI4WNwslAWi5kFu2+idZo/gWStqBuJkBEH+WmvtxDpKROUrcaxXWaVShQICyk9RdfbCK
 rH2vAlUq6Wx6QjLrjulogRKS6pfYOdpcCFrtOZurpcVXW5UYOFKC0cUcpWVYmafqG2Oa
 thLg==
X-Gm-Message-State: AC+VfDxw8QGZYgMoOoEK+fyeAZjjZiP5YaM8gLznxrR1t6tQYmnqRWe/
 R8PvGWbAU2o0anJ7oPeJsWO6m0mhqggkwZC9P2asu+3ZvEq37irZeGmA0LRyGMfIG8e+79YQi+V
 TuotZn3k8yVJANh8=
X-Received: by 2002:a7b:c012:0:b0:3f1:662a:93d0 with SMTP id
 c18-20020a7bc012000000b003f1662a93d0mr1237919wmb.15.1684410769133; 
 Thu, 18 May 2023 04:52:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gxNNkAjZ26q/WSwf97SL0+oXVWIpkTfIUn0DxQ7KnF2kBaAqTYw+B6zAOxKHf+HEQLsFI+w==
X-Received: by 2002:a7b:c012:0:b0:3f1:662a:93d0 with SMTP id
 c18-20020a7bc012000000b003f1662a93d0mr1237900wmb.15.1684410768799; 
 Thu, 18 May 2023 04:52:48 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c294600b003f50876905dsm1843581wmd.6.2023.05.18.04.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:52:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 berrange@redhat.com,  shivam.kumar1@nutanix.com
Subject: Re: [RFC v3 2/2] migration: Update error description whenever
 migration fails
In-Reply-To: <20230518062308.90631-3-tejus.gk@nutanix.com> (Tejus GK's message
 of "Thu, 18 May 2023 06:23:08 +0000")
References: <20230518062308.90631-1-tejus.gk@nutanix.com>
 <20230518062308.90631-3-tejus.gk@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:52:47 +0200
Message-ID: <87ilcpdfg0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Tejus GK <tejus.gk@nutanix.com> wrote:
> There are places outside of migration.c which eventually leads to a
> migration failure, but the failure reason is never updated. Hence
> libvirt doesn't know why the migration failed when it queries for it.
>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


If you have to respin:

> @@ -1456,6 +1460,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>      int vmdesc_len;
>      SaveStateEntry *se;
>      int ret;
> +    Error *local_err = NULL;

You can declare this:

>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (se->vmsd && se->vmsd->early_setup) {
> @@ -1475,8 +1480,10 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>           * bdrv_activate_all() on the other end won't fail. */
>          ret = bdrv_inactivate_all();
>          if (ret) {

here

> -            error_report("%s: bdrv_inactivate_all() failed (%d)",
> -                         __func__, ret);


