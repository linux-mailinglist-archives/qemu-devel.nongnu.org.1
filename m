Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962597E200C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:31:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxjT-0003gr-Dp; Mon, 06 Nov 2023 06:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qzxjF-0003RR-KT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qzxj9-0000R1-8e
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699269903;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/G4MOt4Z5crJ0rR9PTfIucgt4ksq+Vx3Swa9I+GvsFw=;
 b=UDvSgo38jsW6zq6ZiVudBkfFlgi4RsLeWjpLrI6E/vlviQnAqDM/YINSQXWD4BR/EY4VXT
 tpsAxGZDvcl/P/OGdRLU8Ds+JWoYYIzGdVaS91zI/Li5RncnVzbw2eaPEeT9aERujdzVi5
 muAVdm/3qEDportk+jk97+4pLePCxbM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-UvtliHmNMhuf2Se5rwg_oA-1; Mon, 06 Nov 2023 06:25:01 -0500
X-MC-Unique: UvtliHmNMhuf2Se5rwg_oA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32fa41d0564so2258694f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269900; x=1699874700;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/G4MOt4Z5crJ0rR9PTfIucgt4ksq+Vx3Swa9I+GvsFw=;
 b=d88Sr2+NkzpisoPSMWIKN4AMz9WdxlcZYenEvangWCUKtlxPxnLznX+eEriw1urbNS
 E45ZUkKDK8dGnQU7j8fI9QqPOxp7YJVGdwB++IqiO/6ib86KqhXMejHsu+a4r2Tv+H6m
 CCil09WzU72JxP3NlYaSVKaoeToxSCxpEa609WfVZD2UEBLRbiOhbk0iQSL9dg59Jfpv
 nM3afIN1wJqjgSL98d7GrW9xpIKfZDmMSFvLeKWLfhnpVGxpZT+8ICjNPAHkCB7kRrtY
 dsZ7kNtDJxVjHIyobRQEPSJKXkO4mkNNph2obVpdtHJh/isSBinauwoo4RxNaTU9CsGp
 aaHA==
X-Gm-Message-State: AOJu0Yw+snvCQuTVNNjWoAx1vhSD7oGM3aiSrTpJD42h8afu5sshZGT1
 vwQUYVfN3B9h0HtBLWiYxsj/euOZ+p4mETgsSniUy/ZUfqN4QJzGHiLpr6D/gUZh/WYEFtMNBYa
 9tFan9Uij3RePvCI=
X-Received: by 2002:a5d:6051:0:b0:32d:a4c4:f700 with SMTP id
 j17-20020a5d6051000000b0032da4c4f700mr20258539wrt.38.1699269900333; 
 Mon, 06 Nov 2023 03:25:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9lOIM7GCIXqjfrQfMtb9dp6PqFkVIrYLUwlK3VgUUxjl6aODxPDm7BuNnWifkmXNnTXyN5g==
X-Received: by 2002:a5d:6051:0:b0:32d:a4c4:f700 with SMTP id
 j17-20020a5d6051000000b0032da4c4f700mr20258527wrt.38.1699269900086; 
 Mon, 06 Nov 2023 03:25:00 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 g2-20020a056000118200b0032dcb08bf94sm9196471wrx.60.2023.11.06.03.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:24:59 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 leobras@redhat.com
Subject: Re: [PATCH 71/71] docs: Constify VMstate in examples
In-Reply-To: <20231106065827.543129-72-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 5 Nov 2023 22:58:27 -0800")
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-72-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 06 Nov 2023 12:24:59 +0100
Message-ID: <874jhz15v8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com


