Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD17B850D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:26:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4h9-0000dJ-B6; Wed, 04 Oct 2023 12:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4h3-0000W8-CT
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4h2-0006TJ-20
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436747;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cdMRpkFVkK3EOc2pKVmhFEztiwEMB3dP2NUsLEzIA3I=;
 b=TeXtP3GmeoNRoLdF1Ah7WYIs6pE0hElDXw+trQu6oAtVzm514WUv2WNRJK2L05GgQbJSUo
 veQBPCjP86crodSPsoJzxlkUAxhCP6hbJkFGpQBT+Lr7OF2+dvoZyP08jAyX/MBED+auHO
 1OO8vRSmgx16JaxD98IHwR5oz23Gibw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-GTR1_Ha5PEGYj2gUwyibMA-1; Wed, 04 Oct 2023 12:25:40 -0400
X-MC-Unique: GTR1_Ha5PEGYj2gUwyibMA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-405629826ccso18010545e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436739; x=1697041539;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdMRpkFVkK3EOc2pKVmhFEztiwEMB3dP2NUsLEzIA3I=;
 b=Uzu0fXw9us4vgprshp1nHQJ/einnOOuFK/ZzMh8jz7yysYzj0US22i18NDJLD8X/cE
 YcMQQwxpKGvuYvxhxxhPBL2MX8qgLUQugv9vDwjXLBAsqGbOf/cwV0DuivR6NwFyoEWw
 TvMkSRdY42/KWvZaskG3stB9CvZnZ/f5pbM2XJG5D89QrUw0J7DC5XL/tc9yznjqhSaM
 eAeP0hY3FrGW6qRU9Gdrd5JHxo8Iu4jFEtgsyAkH7IO/2Kf9jl8Meo1lhZL0LfyZVLLm
 /lc6cOHh7bxUvUaABgNYSG6r2mlxGzas19MseNdgs2FQCDc+m1upFKE5YwZELGTZjo8w
 PWUA==
X-Gm-Message-State: AOJu0YzI4rslYAM8sKweWSKsnJS3hqZ8qSrTEiLfgX0MAwcAjDdDZcwS
 jinvYR/FugwM1udrOG+wJE1DOxccYk7qO6GpzfWL0+P8prWEYpnmbbFI/OFtgGvXOW3bxUdad70
 +4bCpeo3cnZS6SgU=
X-Received: by 2002:a7b:ce07:0:b0:406:4501:9095 with SMTP id
 m7-20020a7bce07000000b0040645019095mr2707419wmc.40.1696436739728; 
 Wed, 04 Oct 2023 09:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZDgPcwwGnQrWbj6oPBYdDpwpEcGd1p4/RDehg3Kiug5cfJrPOTzJRVY6Fzp7nwfvWsAVAzQ==
X-Received: by 2002:a7b:ce07:0:b0:406:4501:9095 with SMTP id
 m7-20020a7bce07000000b0040645019095mr2707405wmc.40.1696436739425; 
 Wed, 04 Oct 2023 09:25:39 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e11-20020a05600c218b00b0040472ad9a3dsm1879012wme.14.2023.10.04.09.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:25:39 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 27/53] migration/rdma: Replace int error_state by
 bool errored
In-Reply-To: <20230928132019.2544702-28-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:53 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-28-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:25:38 +0200
Message-ID: <87wmw2uzgd.fsf@secure.mitica>
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
> All we do with the value of RDMAContext member @error_state is test
> whether it's zero.  Change to bool and rename to @errored.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


