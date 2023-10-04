Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DCC7B853B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4id-0002So-Fs; Wed, 04 Oct 2023 12:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4iW-0002Of-Gh
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4iV-0006e6-7G
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436838;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NUHOPskgaAZRFehtfXUAP8g2Z/47sSiApApwgeWIEBo=;
 b=O8+9tOJTm3PLwpjZHmrwD/RJeCiQpFxH+epriD0Otk7rfKT26jBc0pBOQRWXPGIiXtF0U6
 BONjFt8LXbV0RXZGFhJJo+jx5Zv50i/KxeH7RVEfXR9uBH9F21htn5zz4w6xxDh38Jut33
 nIiLVZIoEU12izgG7Q8pKOWhBLa8Djc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-QsbzdcdFP1eU7ju4kf_4bw-1; Wed, 04 Oct 2023 12:27:07 -0400
X-MC-Unique: QsbzdcdFP1eU7ju4kf_4bw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-321726b0238so30448f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436826; x=1697041626;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUHOPskgaAZRFehtfXUAP8g2Z/47sSiApApwgeWIEBo=;
 b=czCzZ/3Tf0+16Dn59iB7E6MPZOFzoQe0+iSOaKzpQW1YKYA7g/7ZGZiwe0sLBqP/bp
 mmGD6NOM8jmSfOP8Nxc6f5gQtx5S2UZAs1cRCyAaXSttJdEsqQSH+Uxb9ny9y70P6lgU
 n4a32zZlo+WCsjzJH+L2AQH2JcWIZXlPM0VNV91GQqH3/gGvmG97IjgN7RXm+tqZ7one
 o2xMV6NobwDcQa1zb6PFLTRqs+SqPAvRfRidX1a0HDpK2wOC+uYSo2Yr+I0XbVaJq/Sf
 JVZtMLtqy5YjpH1HRY6fa8wQqwBlJxrHF/LbhaqENs7H6JjGnTvtMkN13OKASD8ms0bp
 a80Q==
X-Gm-Message-State: AOJu0YwI4EqiEdo0xhopB8UFdYWBTpupovOU92WnXDe+f3h7OHB9U9aQ
 y3+G4qvRiCIqS4cpeAbjGbYSpXs1rbWiHHs2u8mw4XdzXVWIRykq6yKg2hDRk+2PZzfwPLWtXdW
 901k76W6Nn2Ocdss=
X-Received: by 2002:adf:e5cb:0:b0:31f:fc72:49fc with SMTP id
 a11-20020adfe5cb000000b0031ffc7249fcmr2445077wrn.23.1696436826070; 
 Wed, 04 Oct 2023 09:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq75NBotmBWFX2s2H1W4HBiM7wMTd2BkjwVzQZ06pHbFpBzeRBfwnWYMKD+xr+o7n+/77uSw==
X-Received: by 2002:adf:e5cb:0:b0:31f:fc72:49fc with SMTP id
 a11-20020adfe5cb000000b0031ffc7249fcmr2445059wrn.23.1696436825791; 
 Wed, 04 Oct 2023 09:27:05 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l19-20020a5d5273000000b0031ad5fb5a0fsm4375198wrc.58.2023.10.04.09.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:27:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 28/53] migration/rdma: Drop superfluous assignments
 to @ret
In-Reply-To: <20230928132019.2544702-29-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:54 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-29-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:27:04 +0200
Message-ID: <87sf6quzdz.fsf@secure.mitica>
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


