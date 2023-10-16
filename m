Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 180417CA095
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsI0B-0004q9-Qd; Mon, 16 Oct 2023 03:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsI08-0004pa-Bk
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsI04-0005rl-Ix
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697441211;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sdUDsCJt+mEo5p73/qufWoh0YUeLb5NW42E22qjewm4=;
 b=U4r6Pl4OJ3BOjLDDvTARGgKyyuNrODNDw6UR0PjEe0I9bfWy72krL5RkBuDK3t6wr3dmYA
 Sfy9xd7IcvGh/QTzLWm1dK0ag9Dm25bz70hPHhnUEGNnoHFbbrWj82NIp/JQ5XTlBmCUns
 jBeh4kmdTitFJ/zjcxTkqr5VobwKwGQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-san-Jv1VMMeF5zknXXEgCg-1; Mon, 16 Oct 2023 03:26:45 -0400
X-MC-Unique: san-Jv1VMMeF5zknXXEgCg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40554735995so32402685e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697441204; x=1698046004;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdUDsCJt+mEo5p73/qufWoh0YUeLb5NW42E22qjewm4=;
 b=KehMwEoLZLl+mpCdTWcqdkOdHxu7IOpXbde6fPwp3n7sGUGn5MxoYMTE/xCXrajO1L
 KeyhU/n99aMgJNle8fvDfClxy3QkSa5ZBYnNb3lpcRryWfIZmxWFns8fRAzmxLoWbIwG
 Hym67cqscYu3yQgNPDFw9d8j2/4j0c1qdFvmgZdpVr5oIvICId8T4d5VZvY8dE1KyKYk
 a6hLUPlNHICLkRNYclnPerV95YL5SUTVrJLfS5lsHFFHHcGU7IFqBcxxml3JMh+TtHmu
 At2AUZwl57mdAqKUXcseWzRbJPIhD0k1LHZGgBbNX5U/v67r7n1H/hT5Sqd29rHIaRv7
 nLdw==
X-Gm-Message-State: AOJu0Yxe0hT3KHp4VMuBCfdqZr5SVgDI3aaCtp2aRt5T5OarLQf6qcUl
 OZtf/n3fKjKoYIfoe8/RZ+xfEdCbRfJI6JLH2MMdWDOymtFKlYZJ0kqvoYRcXlHJm+VSuTdZPKQ
 +unm2DZU0Cf9Acak=
X-Received: by 2002:a1c:4b1a:0:b0:403:cc79:44f3 with SMTP id
 y26-20020a1c4b1a000000b00403cc7944f3mr27792901wma.19.1697441204351; 
 Mon, 16 Oct 2023 00:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj0a+SbAq/hBuXlNytid8X6MHveTmbEa43zVHfSX8g5yDPn3i52jOOl6iDEYeaDZ7Et/lYeQ==
X-Received: by 2002:a1c:4b1a:0:b0:403:cc79:44f3 with SMTP id
 y26-20020a1c4b1a000000b00403cc7944f3mr27792886wma.19.1697441204037; 
 Mon, 16 Oct 2023 00:26:44 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v6-20020adff686000000b0031980294e9fsm26383488wrp.116.2023.10.16.00.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:26:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/4] multifd: reset next_packet_len after sending pages
In-Reply-To: <20231011184358.97349-5-elena.ufimtseva@oracle.com> (Elena
 Ufimtseva's message of "Wed, 11 Oct 2023 11:43:58 -0700")
References: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
 <20231011184358.97349-5-elena.ufimtseva@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 09:26:42 +0200
Message-ID: <87wmvn3u4t.fsf@secure.mitica>
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

Elena Ufimtseva <elena.ufimtseva@oracle.com> wrote:
> Sometimes multifd sends just sync packet with no pages
> (normal_num is 0). In this case the old value is being
> preserved and being accounted for while only packet_len
> is being transferred.
> Reset it to 0 after sending and accounting for.
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


