Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB7826920
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 09:14:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMklc-0007rx-Ew; Mon, 08 Jan 2024 03:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMklT-0007rR-17
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMklR-0006dP-DF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704701620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96tSQWIoS9H1nKBB9+xWuNN8tLbrLvsL455kysr4O/Y=;
 b=X2mTSuBvn9P6zmtCJzj8SLWMQk/mUHrZ++2WHhi/PgsxX55+tH7brE+9cCijXBssIwW+2v
 DXMKEmvQt28SKLntH3RAK7l2IHUrTotsbq207M6ENhQGZWMLPxcfvK7LUaTqO1K2a7DAQe
 h7a25uZoylUuCu5FmdWqlTZKa8GQxBM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-0GqCF5BbPTq92nZhOQttNA-1; Mon, 08 Jan 2024 03:13:33 -0500
X-MC-Unique: 0GqCF5BbPTq92nZhOQttNA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d44608e379so2048315ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 00:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704701612; x=1705306412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96tSQWIoS9H1nKBB9+xWuNN8tLbrLvsL455kysr4O/Y=;
 b=gGc/i34zgs6wueLiXmHeJvl4gJak7Aga0fyPZ+2Bd2bWwDeRtYwTRtDVNJSV3DbBo9
 MHnW4iDwDdeH0/7D4/xH5xwzYUaC8hUO867NkYkUQUorkbzVOMYnRj0SCyOzRk+JpcNP
 u5wBxcn/dnM/LsoIQxNWswuf7rbpf+5WsLwrb9G7HrmBOBaly5m3KlOJnNSv/BbkF/mG
 LDrq7Vfb9Tv+3FRx/8axp683Gjs3zrf/NcxkgiEYM9ZKsZkfjP9F447ncnFS1hD/QJyI
 KhZpnkq7ItR1ZD4UfbUlpM1vcuTQVtazDndL2xB8Lax9WILF7qo5YbTgvtY6pVdr+LNQ
 65nw==
X-Gm-Message-State: AOJu0YzpECeWlSvOCLSV44KP5yu7CFwKAT+RF0MWZbEUg54h+yiDf3+8
 WML/NQby3ATowGe/xZVkI6pKJ+F5roy1LNqtRyj6Kbx/1ZHalZXpRlAOsfZLktUB3JqJy7zKoE1
 pEpsX3Wv4nN5L7wv8axVzk9s=
X-Received: by 2002:a05:6a20:68a4:b0:199:9259:aba0 with SMTP id
 n36-20020a056a2068a400b001999259aba0mr3892133pzj.1.1704701612199; 
 Mon, 08 Jan 2024 00:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZnaBLvLhEH3inut/Bd+9r8lcgXW5TkU4Xty6WM5x1aQ7xxyuIjKUuLoi3Xtbcg8O/gdPpeg==
X-Received: by 2002:a05:6a20:68a4:b0:199:9259:aba0 with SMTP id
 n36-20020a056a2068a400b001999259aba0mr3892127pzj.1.1704701611901; 
 Mon, 08 Jan 2024 00:13:31 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 g16-20020a63dd50000000b005ceb4a70483sm5327720pgj.7.2024.01.08.00.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 00:13:31 -0800 (PST)
Date: Mon, 8 Jan 2024 16:13:25 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/4] tests/qtest: Add a helper to query the QEMU version
Message-ID: <ZZuupZmkbQxHbHzt@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105180449.11562-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jan 05, 2024 at 03:04:46PM -0300, Fabiano Rosas wrote:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


