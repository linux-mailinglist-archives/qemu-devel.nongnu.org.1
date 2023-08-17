Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A2977FDDB
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 20:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWhii-0001XG-Rx; Thu, 17 Aug 2023 14:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWhig-0001Ws-OD
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 14:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWhie-0008Sq-NB
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 14:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692296859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWUd035lQRidOiksI4knif1JuwuvOFg5hUGR74uNUAQ=;
 b=JrTZbaD5u4VzJhS6JOUlfyc6rN+qWZ622K8G4P5wE5neSfYf+Mj3fcKTQD4UTnwfmKIJXn
 kKtpxFUzkPerz1B3tylphQc8siEB+ZgCXdSTpHLXZOE9LabubAq37WQKG4IsGc/KfGjbUA
 H+PgSV3yY3b3Kus1/1WHmWCw2AQ90LM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-D0rvD8iBMlGijp2_fNAQZg-1; Thu, 17 Aug 2023 14:27:37 -0400
X-MC-Unique: D0rvD8iBMlGijp2_fNAQZg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-56df42737e4so39691eaf.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 11:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692296857; x=1692901657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWUd035lQRidOiksI4knif1JuwuvOFg5hUGR74uNUAQ=;
 b=B2C7qnuYalq/cMwpyaI7/fhDhT2zXmgFN0gQzITAnETUZeEuiCpL5dzVVkNP5T0XNl
 ECa8yQVrIz+L13uQjHnvTo0v2H90hRLjn8wBU3Bv09yIaKIPhXPC4W0n49WY28y6F7ic
 xQpE9D+9dhW2wo6Dlls8KMmDJttRmTC+abNBGlTff6KN74EwShWeep+9+L2ZkHebISzl
 0bYkT60MLpCOIwj6HI+xnFw4ENyZ644ctYJqcIExIUZciH38d71TyFatBbR0gLElYY6+
 4/Yu7gx7R+ZsxJNqcpq98S4yS3ogZ4FARfDdwJHt16uwQAkG0+Ggs2I050UFWbawdWA8
 DrjA==
X-Gm-Message-State: AOJu0YxrksWTZPADfKE/d+jiMV444AfWJ7KHtqlD/5wc7NqYWcSSZUA7
 /Wx2gYKKEwYlBPYjJPA9MO490rlNTuWKm2yXjweC7bZ2GVd61/d3stVoNF/jk8y3hcv+bC+ABVq
 N+/UM4237TrDEPfY=
X-Received: by 2002:a05:6358:c62a:b0:139:840a:d357 with SMTP id
 fd42-20020a056358c62a00b00139840ad357mr281729rwb.1.1692296857005; 
 Thu, 17 Aug 2023 11:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUW2+8/gL9/O9Wz68DvUiE668H1SS/Ni0rsRw0tdCz1outvBrhayAUGxpUsM9EWAR7AlqlWA==
X-Received: by 2002:a05:6358:c62a:b0:139:840a:d357 with SMTP id
 fd42-20020a056358c62a00b00139840ad357mr281722rwb.1.1692296856756; 
 Thu, 17 Aug 2023 11:27:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t17-20020ac865d1000000b0040ff0590fd2sm26750qto.87.2023.08.17.11.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 11:27:36 -0700 (PDT)
Date: Thu, 17 Aug 2023 14:27:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V3 01/10] vl: start on wakeup request
Message-ID: <ZN5ml+277ufAE2jm@x1n>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
 <1692039276-148610-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1692039276-148610-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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

On Mon, Aug 14, 2023 at 11:54:27AM -0700, Steve Sistare wrote:
> +void vm_wakeup(void)
> +{
> +    if (!vm_started) {
> +        vm_start();

(irrelevant of the global var that I wanted to remove..)

Calling vm_start() is wrong here, IMHO.

I think we need to notify everyone on the wakeup before really waking up
the vcpus:

        notifier_list_notify(&wakeup_notifiers, &wakeup_reason);

There's resume_all_vcpus() after that.  I don't know the side effect of
resuming vcpus without such notifications, at least some acpi fields do not
seem to be updated so the vcpu can see stale values (acpi_notify_wakeup()).

> +    } else {
> +        runstate_set(RUN_STATE_RUNNING);
>      }
>  }

-- 
Peter Xu


