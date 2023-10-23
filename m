Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CB7D340D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:36:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutAn-0002FY-RY; Mon, 23 Oct 2023 07:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qutAh-0001ad-EJ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qutAf-0003oJ-UW
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698060753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9vJQOR83wDAY8cjZE5Q3OagKBgR6pSt238Tk8Zec2R8=;
 b=UlOFDjSHQiCDtgGJT+3K4oa+aCjtE+A10w95S0CWlKVMhZEnvppfeHnBK8fi44qfdIAXFf
 PfBpzEQwlTDzWqZ529zWTFzi0VQy6F1aDvYIrs8t/fqOXGmQDv3qwv48SRcHNmsbFmXJH6
 vNsH+SWK2sSqFlHcZvTyScIh/CK2LbQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-pXrjemPVN4-Yg6bzqt86fg-1; Mon, 23 Oct 2023 07:32:31 -0400
X-MC-Unique: pXrjemPVN4-Yg6bzqt86fg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408597a1ae3so11168255e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698060748; x=1698665548;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vJQOR83wDAY8cjZE5Q3OagKBgR6pSt238Tk8Zec2R8=;
 b=oyrAZdQJejTnrDWK7r7oRwBcpexcJwQhEtoCshu0+CSnvawK8i5FFwBlF4ePRCwzl/
 kWoHQOdrhYa8jv72TOajA7R2Y4tMJtqDtDWPx+jWaAY3Oa7/lpmsqPmKUJmRLH/L2Ero
 N0/x+Ax6R1JNk02AoNsZcy1YF4T/MLLJEahR0+XedQVn+8T+ufL7d/7Gg0D2tWylHIjt
 FG/vVBPqACOtQZoNadqksMiD10QdGlrUikU0pxL4qolApqjMN7WMqYZrqtPEjmrYyLg+
 M3gawMsjCPoU6q0jznsF3sBA16N0aWjseoLW0wqKlcpyoGcbxb3pougvk3vGQ8h7MZSB
 nATA==
X-Gm-Message-State: AOJu0YxccD2ssRwoJ1nHjz5jwcUqc/ALA3AGlj2YF8HkXIAueCdpbxIg
 VX/BVMw4ezp/CzcFNt7AQMD9NZwJ6facuTmgQZjKe6SLesFLYxuAcCyyQmC102UsnqD4emAms//
 2vXFxAcTrjH6L5mo=
X-Received: by 2002:a05:600c:4444:b0:405:49aa:d578 with SMTP id
 v4-20020a05600c444400b0040549aad578mr7457016wmn.37.1698060748493; 
 Mon, 23 Oct 2023 04:32:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPAkQA1F/v6LSybbvjOY3J8lSmPZ9/J64gLEefy3cLQa6z7lMhUct+IYZDfp407yQ3rArNLw==
X-Received: by 2002:a05:600c:4444:b0:405:49aa:d578 with SMTP id
 v4-20020a05600c444400b0040549aad578mr7456997wmn.37.1698060748164; 
 Mon, 23 Oct 2023 04:32:28 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0a4800b0040775fd5bf9sm9366284wmq.0.2023.10.23.04.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 04:32:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  qemu-s390x@nongnu.org,  Halil Pasic
 <pasic@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  David
 Hildenbrand <david@redhat.com>,  Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] hw/s390x: Don't call register_savevm_live()
 during instance_init()
In-Reply-To: <20231020150554.664422-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 20 Oct 2023 17:05:51 +0200")
References: <20231020150554.664422-1-thuth@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 23 Oct 2023 13:32:27 +0200
Message-ID: <87lebtshf8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> We must not call register_savevm_live() during instance_init()
> since instances can be created at any time, e.g. during introspection
> of a device. We must register the savevm handler during realize()
> instead. Fix it now in the s390x devices.
>
> v2:
> - Fixed bug in the third patch ("sas" -> "dev")
> - Add an early return in case of error in the third patch
> - Added Acked-by/Reviewed by from David and Eric (thanks!)
>
> Thomas Huth (3):
>   hw/s390x/s390-skeys: Don't call register_savevm_live() during
>     instance_init()
>   hw/s390x/s390-stattrib: Simplify handling of the "migration-enabled"
>     property
>   hw/s390x/s390-stattrib: Don't call register_savevm_live() during
>     instance_init()
>
>  hw/s390x/s390-skeys.c    | 35 ++++++-------------------
>  hw/s390x/s390-stattrib.c | 55 +++++++++++++++-------------------------
>  2 files changed, 29 insertions(+), 61 deletions(-)

Acked-by: Juan Quintela <quintela@redhat.com>

It makes things work for my test, Thanks.

Should I get those through the migration tree?

Later, Juan.


