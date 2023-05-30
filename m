Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BB8716CC7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:46:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44MX-000841-RQ; Tue, 30 May 2023 14:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44M9-0007nK-KY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44M7-0006AH-HT
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685472362;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QFy1V+SfyKU7c2+O8ZMl0YlwFxMSqk3XO4lp6SEZVck=;
 b=ZGlAx7f7NjdZ8TpMewFlUficyM1qRTPWfoCoyBWYz4hj15c4lb3p+Bu7Q/L+lybj6j9wcs
 Uon7YYYg3iaQ2RrPKlGs3/godpIoMuVgjCu/H1uhVnjI/QAHiW/CSXGe6wFBkWfdaxYQLc
 x2umE10Q3eurLeeez2niBxMkcILAs6E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-zoqP26BCPH6x4EqPL27CSQ-1; Tue, 30 May 2023 14:46:00 -0400
X-MC-Unique: zoqP26BCPH6x4EqPL27CSQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-307897bc279so2605832f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685472359; x=1688064359;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFy1V+SfyKU7c2+O8ZMl0YlwFxMSqk3XO4lp6SEZVck=;
 b=fjThN2JJDwxBXRYd8ev0oEB+4q4+pQeXa53rABquD64Th4mwYmzBuuVAAAYBcbn/7I
 cBhPEQUZ6CTC9Tgu93LHTt7qP17KcH0l0S12+2x+XpA2dZ1BoeHdHoQ5qoVd2u/pFBI/
 5+n7u9VfY3MLhv1wHEkRlGC1qsaG/Vo0tEnrgrpBtTK8x3l5BfinasGlcWgbbHW8eUCZ
 Mhev24yTQahVfRVx57e1UqQB1JvBF19G/EcxHL853MRmlNIIe3eZvbaTeH7iROJv1G8F
 2qIVi3haKCUprteNMvgC4a2yn+0C3pNYMlaaPN1LnK1QDXfqCq5AcYUSjpfpBZtGkM6f
 htZA==
X-Gm-Message-State: AC+VfDxkdgQP4tdtSb0Iq5TjgWwe2fjgITe2/kMNbyHZ0msXFUgHDnCg
 0qAdmW9Uy48zehiO/MT0faEWp62vE0YDpJuRLhTTXnufXFFMSkXVzWKhTqytiNn5XjqrPtg+IUT
 ptj23klw0T7jNlAo=
X-Received: by 2002:adf:dd45:0:b0:30a:8c0b:3209 with SMTP id
 u5-20020adfdd45000000b0030a8c0b3209mr2551731wrm.9.1685472359378; 
 Tue, 30 May 2023 11:45:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4lDAIU4ArQV3xzXotllxaiT3ddlySqOErXLdK67p962tfzb5JleEoDGjhw7cPKCa/Pq/ehMQ==
X-Received: by 2002:adf:dd45:0:b0:30a:8c0b:3209 with SMTP id
 u5-20020adfdd45000000b0030a8c0b3209mr2551717wrm.9.1685472359109; 
 Tue, 30 May 2023 11:45:59 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 r10-20020adfda4a000000b0030644bdefd8sm4105518wrl.52.2023.05.30.11.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:45:58 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  andrey.gruzdev@virtuozzo.com,
 peterx@redhat.com,  leobras@redhat.com
Subject: Re: [PATCH] migration: stop tracking ram writes when cancelling
 background migration
In-Reply-To: <20230526115908.196171-1-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 26 May 2023 13:59:08 +0200")
References: <20230526115908.196171-1-f.ebner@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 30 May 2023 20:45:57 +0200
Message-ID: <87jzwpvesa.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

Fiona Ebner <f.ebner@proxmox.com> wrote:
> Currently, it is only done when the iteration finishes successfully.
> Not cleaning up the userfaultfd write protection can lead to
> symptoms/issues such as the process hanging in memmove or GDB not
> being able to attach.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>
> For the success case, the stuff in between the old call and new call
> site should not depend on tracking to already be stopped, right?
> AFAICS, it's just some QEMU file operations and manipulation of
> migration state and counters, but I have only limited knowledge, so I
> thought I'd better ask :)

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued for next PULL


