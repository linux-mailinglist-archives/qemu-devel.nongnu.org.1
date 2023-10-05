Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6B7B9B60
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoImm-00085M-M0; Thu, 05 Oct 2023 03:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoImk-00083e-3a
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoImg-00069G-Ki
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696490911;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IXFFtOifZgk8g27Rtxt0rADBkItXjqZ4ArfsL/OunL4=;
 b=OFrVOfMeaxehtr6hbl5KgLvxtVoQsRhY0NpZkuNMgQquHKEbASHjW3K+pr7zs4r22p21Fb
 igTsYAVnxUV2f4GqJrC9oRfKFeWa12BgHpT/wqQpcOYB/zfhCpt8ZHMQi8sKehXVLEFLLc
 ZVUO0VApa6hiQHcdiCICQ+MAH8bRl/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-1iHqws81PaCiF3MQwXQ95w-1; Thu, 05 Oct 2023 03:28:19 -0400
X-MC-Unique: 1iHqws81PaCiF3MQwXQ95w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32339eee4c4so540757f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696490898; x=1697095698;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXFFtOifZgk8g27Rtxt0rADBkItXjqZ4ArfsL/OunL4=;
 b=deJSiHkfbcpLEtZU+FhGAaRRF+cdkGzejiyIov09WxigI+SWLGA8GAlpd7mrsjtlwX
 92LRQqBvyiDIgkN2KTZq19ImUm6yXpWMTWChM95Du7Qogx8UR45GLPcyrddQxwCc4BQI
 /ZvdtzuC8gRolsUsVA1JPa1rywPu0ElJNbKnUFbsS/mJY+6MfT2FiH+5VwprsWnMs3O7
 Aiw0ZJQHcMTi6ksC6r9QZQKewUMbfAh9toSMcT6xaC8ZxmE1UNCrRcUb+XKfSc+H88x8
 aoRMgCeIzn1odH8UhyrFRHJ9Qffr5IhpqbUP3q7ATteJB9g8ML8zJByU8vejRF9UxIij
 O3Cw==
X-Gm-Message-State: AOJu0Yzqro29g/2QpxW45512pa2UXKeyhEAcKU9PtsxwNKaUOMI+RXAi
 MStoHIt9VEndN40TF6freHtmAKilu+gc4xsoTplVDVraI66ep+b74e/T880s5kJlNcRWj2Wi5fi
 JC2MDzFzNF9I6sWc=
X-Received: by 2002:a5d:538f:0:b0:323:306e:65cf with SMTP id
 d15-20020a5d538f000000b00323306e65cfmr4062481wrv.10.1696490898758; 
 Thu, 05 Oct 2023 00:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHzrSgBrzowoJ3G9g/NVrsjsDERLXc3JnjUgRIvqxGm6+X7eBdsttP/rRfbMdI9uvb735RNw==
X-Received: by 2002:a5d:538f:0:b0:323:306e:65cf with SMTP id
 d15-20020a5d538f000000b00323306e65cfmr4062468wrv.10.1696490898439; 
 Thu, 05 Oct 2023 00:28:18 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o3-20020a5d62c3000000b003179b3fd837sm1062533wrv.33.2023.10.05.00.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 00:28:17 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 01/10] migration: Display error in query-migrate
 irrelevant of status
In-Reply-To: <20231004220240.167175-2-peterx@redhat.com> (Peter Xu's message
 of "Wed, 4 Oct 2023 18:02:31 -0400")
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-2-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 09:28:17 +0200
Message-ID: <87sf6pplym.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> Display it as long as being set, irrelevant of FAILED status.  E.g., it may
> also be applicable to PAUSED stage of postcopy, to provide hint on what has
> gone wrong.
>
> The error_mutex seems to be overlooked when referencing the error, add it
> to be very safe.
>
> This will change QAPI behavior by showing up error message outside !FAILED
> status, but it's intended and doesn't expect to break anyone.
>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


