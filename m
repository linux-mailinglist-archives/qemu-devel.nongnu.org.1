Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A0A7DCE43
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:53:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoFy-0000Bp-OS; Tue, 31 Oct 2023 08:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoFu-0008UT-R1
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoFs-0003ui-5Z
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698756839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7SLCW0hEg8QgdTnxv6Id6d4Qoj5ITv8VgriydfzTSyc=;
 b=ZAaBe/+fpeuw8BfulJ8e6ZZQ7Th6rCCasF9wxFlXu6aCiNpGnq6f992EJQ41IHZBjAN0RD
 EPRymRyah/vIFnBbSImsPaCagQax3eD3sm9USjS2yUdgcNCEbv+SlL6vM05cC5Op+WsHBn
 o+uxpvbabi32bOHEM49z+wBPpYzNNtg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-7tl0XsjQNpSUhvMQS-kB2A-1; Tue, 31 Oct 2023 08:53:47 -0400
X-MC-Unique: 7tl0XsjQNpSUhvMQS-kB2A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4092164eceeso41675995e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 05:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698756827; x=1699361627;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SLCW0hEg8QgdTnxv6Id6d4Qoj5ITv8VgriydfzTSyc=;
 b=ImNHWvN8Dqt6j+t53W7hFran0kKY0b4oRiOCXwBdRIuwkpMa7BIRhsLMgKxYaiUGIX
 dRc7dAKSvY31ARIZdEqggDbgbzCxFRmN01zSpQ4Fi92hZSJIDUqjIJ/8ZaL1hFXltb4q
 eKdz6KdXb9kkw6xG2O3b7TQ1tJywwLLKXp22g3ij8cxSqS4EO45iz8Z3mYTtFIws8yeL
 ctIEW1zIUB4yFkSXrUr5HdthT2A90rrPEqflT8QWms91ph5KXvQIjp9+zlx/jPuME6ug
 WSvZ4VjY31uaw4T/rY5pWUb8wQaI3/0v+2lj4mt9mH3k8Hk2uabaYphLX39X8Q6az95T
 TWWQ==
X-Gm-Message-State: AOJu0Yzd4/i/ruRBxM4e5TQDfRAxfyBRALgWNIAe+hnrJAK2t2/YNn9z
 /HheB21I52RgHJ6Dpk++AT8ZKSRv/8Gny9mm0qKi8CcxV/oz4SdZqcIeE6O7e8aNSnCxxLkg0Ym
 785xzznKMVJLdK6g=
X-Received: by 2002:a05:600c:3148:b0:405:1c19:b747 with SMTP id
 h8-20020a05600c314800b004051c19b747mr10645448wmo.15.1698756826899; 
 Tue, 31 Oct 2023 05:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfxICm7pEAKsFXscR6PAdKGhXotK5L9x0+11QTZvyDeHdXH+mPL6wcWsffJmXjjup9eG/nJQ==
X-Received: by 2002:a05:600c:3148:b0:405:1c19:b747 with SMTP id
 h8-20020a05600c314800b004051c19b747mr10645433wmo.15.1698756826529; 
 Tue, 31 Oct 2023 05:53:46 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 w2-20020a05600c098200b004063d8b43e7sm1651013wmp.48.2023.10.31.05.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 05:53:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Joao Martins
 <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 4/5] migration: migration_stop_vm() helper
In-Reply-To: <20231030163346.765724-5-peterx@redhat.com> (Peter Xu's message
 of "Mon, 30 Oct 2023 12:33:45 -0400")
References: <20231030163346.765724-1-peterx@redhat.com>
 <20231030163346.765724-5-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 13:53:44 +0100
Message-ID: <87il6n7y1z.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> Provide a helper for non-COLO use case of migration to stop a VM.  This
> prepares for adding some downtime relevant tracepoints to migration, where
> they may or may not apply to COLO.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


