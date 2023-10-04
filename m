Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 998417B8187
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2PA-0007vW-01; Wed, 04 Oct 2023 09:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2P8-0007vN-AQ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2P7-0005WS-0c
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696427948;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kjkwfs9PO7EYpPCvHwGquosIVndPVHsQsBLdia+/wk=;
 b=dza07cd53g4frLjLdh8dx2G4Yty//ZhHYNie8MMKeRwoHtkCF3CQTalmccpjBhppmlMtFe
 Bvsk1bpjoKj4yo0JczvNZOp7fiXcojCpOFrrOyOuwbk2odjOPxDQBrPeNK/drmPLM0nEbg
 DcYCWfv+dwUtvEOQd+38KjCHdWwaCNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-7d81QF6IOf-UD3CLEocboQ-1; Wed, 04 Oct 2023 09:59:03 -0400
X-MC-Unique: 7d81QF6IOf-UD3CLEocboQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so16795605e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696427940; x=1697032740;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kjkwfs9PO7EYpPCvHwGquosIVndPVHsQsBLdia+/wk=;
 b=iMjBn94jKQNa26QEUdcagnlLDuyxef7Rb6KIp7GnMBbgsO19UZb6fIs3qmvWD8IBS1
 H5/SlUZgUKjeleJxGhOhgJASDIVYAJKft7O/ftKUMaKOYo4/VgdTYzk2ex8omexBDg0R
 wbQKVRQQhSRM7waJeuKVdU7kYsiCgN0VPumKqeqBqVgfbHm9fFIyToUW0wgWy6SMKenD
 MYSmZF+yYrFsD72UaOn85ADaBDe4ikcUE9jLG70bc8Mis6WYALhe2H0sGuFFbRlZK5fK
 VkXrwZATFTi8Ev31byI/j0eWJn2/HHIz94AsY3WHRYC67GeoyIpwqi1VJ6Uf4KnDlZQF
 cJiA==
X-Gm-Message-State: AOJu0YxYlLrSugSN6iuhusoeaqaNa8hejx12Pc+mCRJ6ZkU3ZfCZTo+L
 fgg72Esa7my9NIW086+rvCO+BWc+LwLUEP5BFsKxL1KfEPapm139BNm7fYPdNlrvcdC1OzvEqhJ
 AK14R22E6JHQL9EE=
X-Received: by 2002:a05:600c:b49:b0:406:7232:1431 with SMTP id
 k9-20020a05600c0b4900b0040672321431mr2732030wmr.33.1696427940172; 
 Wed, 04 Oct 2023 06:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9TIizJizOk3jR6723OIGnnOUYyUEBzmYVTpXaCzchP0FpjSHkGacuP8yOvCiA1/S+FFiPJg==
X-Received: by 2002:a05:600c:b49:b0:406:7232:1431 with SMTP id
 k9-20020a05600c0b4900b0040672321431mr2732014wmr.33.1696427939884; 
 Wed, 04 Oct 2023 06:58:59 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l16-20020a7bc450000000b0040536dcec17sm1606511wmi.27.2023.10.04.06.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 06:58:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/migration-test: Add a test for null
 parameter setups
In-Reply-To: <20230905162335.235619-3-peterx@redhat.com> (Peter Xu's message
 of "Tue, 5 Sep 2023 12:23:33 -0400")
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-3-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 15:58:58 +0200
Message-ID: <874jj632vx.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
> Add a test for StrOrNull parameters (tls-*).
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
queued


