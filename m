Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 000CE73A7FF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 20:13:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOnr-0000bK-4f; Thu, 22 Jun 2023 14:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCOnp-0000aH-2F
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCOnn-0002Ug-NW
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687457583;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eUFg8VEyakOxwujkPxQq2SFC9ks+nhH7uTZBH12zXfg=;
 b=f96v3xP84kMwzkz4ci9cp+6TVAqgMNByQ7y2RQLJ5eeCAMLJ5xXghZUbAcZf7w5A7+ONvm
 bvizokKW1F+XUuehqDXSKLXVxdxEF4/JhyUOokBoKjQwUs+YhpbOpODGPctSZZrKEaSmCp
 pC/EQuGG76hJA2WH2Yc/fFJphAOARvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6CVsJX9RO9yJ_JeQRqk2kw-1; Thu, 22 Jun 2023 14:13:01 -0400
X-MC-Unique: 6CVsJX9RO9yJ_JeQRqk2kw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f96d10ebd8so28268695e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 11:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687457580; x=1690049580;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUFg8VEyakOxwujkPxQq2SFC9ks+nhH7uTZBH12zXfg=;
 b=RWlkDzGDn2jc/P+ePBdNQKvmfP97KqVScvz4rifo4qgTLQNq0bI5N5oUHVxsQR3X2O
 Mtn4vjaXB1cSmj2nufk/0XkhXWvis/sS5f6G/Lkq1V1ze/wRSecwUmdjeZpohKmzR1SP
 KrhxucBpxhzWx9izxFEg95yD9pBi46oD934In/zVcTVbefpxb32ByDq7gKYB0Q5rXRs/
 U9poajZENwVDdZHxK72bDm+BswgfsKIFU9WwgPDKTA5BH6u6dk709g+a6TRdGgIcqt4U
 YHrens4h1VVaFJ1VN/883CFMBbr9C10fIs2yLZ9edzDYi3RxAKLDW3I09GWCIuvG5dp+
 rolw==
X-Gm-Message-State: AC+VfDy7GoTy3rpemT1cKBIFihjOkOINXqIgm9K5OWHEgeNsogZvPAP0
 uaSPhkA0ri7HNtAP+QeN4KG8NARjwRrlRQgGuXYM1hj31lPpOyB/5tzT0A+gg3QIq4EKE9NwSk7
 YUxJUMcMAAvcKmn73Y24V9PHGXAPGDQTlI0ixuaTA+jVH5WDgdwqexXFKq2t8KCLhH4hLOM8Njz
 mJ2w==
X-Received: by 2002:a05:600c:2290:b0:3fa:7227:852 with SMTP id
 16-20020a05600c229000b003fa72270852mr2085966wmf.17.1687457580410; 
 Thu, 22 Jun 2023 11:13:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6AY6g1Flx+gpLOtdSd0+J7fJkPZtrNr1X6PjHoXbj87LKVdK1iM02P2IvaeCptF083bI/Nxg==
X-Received: by 2002:a05:600c:2290:b0:3fa:7227:852 with SMTP id
 16-20020a05600c229000b003fa72270852mr2085945wmf.17.1687457580094; 
 Thu, 22 Jun 2023 11:13:00 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 n18-20020a7bcbd2000000b003f90846d8a7sm192678wmi.6.2023.06.22.11.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 11:12:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
In-Reply-To: <20230612193344.3796-5-quintela@redhat.com> (Juan Quintela's
 message of "Mon, 12 Jun 2023 21:33:42 +0200")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 20:12:58 +0200
Message-ID: <87wmzve579.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Juan Quintela <quintela@redhat.com> wrote:
> Only "defer" is recommended.  After setting all migation parameters,
> start incoming migration with "migrate-incoming uri" command.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Nack myself.

Dropped on next submissiong.  keyfile properties suggested by paolo is a
much better suggestion.

Thanks to everybody involved.


