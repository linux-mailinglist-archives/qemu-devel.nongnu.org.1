Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA9A7EA5E0
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 23:17:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2fDn-0002eT-J2; Mon, 13 Nov 2023 17:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2fDa-0002e3-2z
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 17:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2fDV-0007dL-OI
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 17:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699913736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pUXp8g926TRqyKBXhmemlBdXxvKYhO+mfsLtOgrvTw=;
 b=c/JDg/LCgqX5gBnfJQeMKhW+gpsOq5bdp9Rr8IhL3UvbeI6ZvXJhcgJDtQ6MnCr2e0reQ+
 krbcBwa3+po9hT1SWleNrGUQZY+Ow9sF6gqxYhPjU1Yp0T+cIgUum8UhcrW3xcPpB6WrlM
 9hXMNZlaKWgErzW/pnmJ8v8EyR7g4to=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-oJ2v5mi4MQaga4WdSEc2Jg-1; Mon, 13 Nov 2023 17:15:34 -0500
X-MC-Unique: oJ2v5mi4MQaga4WdSEc2Jg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66cfa898cfeso5729006d6.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 14:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699913734; x=1700518534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pUXp8g926TRqyKBXhmemlBdXxvKYhO+mfsLtOgrvTw=;
 b=Q/bYj3rwZktYtyeCQaa6QAOQSa7J934kTQ+E0hhUyVRUp1V5jQU3P5orBJhiG6eMHI
 oe06nmtTC+CjVvhtdzZcH80+ohjA3umRuY1a9puFUyEOS8hz/7R8mVTwpnenprJcRrGX
 0MPM7A7p5h2f0NyFeGKooGu+Z+O15x8iqHL/JuIZ8ve4XuO7+rphkPSunG5+Oa6nTrWV
 Ed0umVRIXR4gVpqyKKmOf6jVhsSuWYDtr+v4qMU88qXljHqMQtLQr+jIjlelhOgpQ0WP
 Ib58Rvt9szr2VKFPv041U/Q8eA9m/GmCOTnvyPGQMYkkR0+hp7nGTUoEUBjd5OMT8VY5
 RMZg==
X-Gm-Message-State: AOJu0YwdNZidz+2E6kvXbR/4wU6rNOLV4+bg6kbWS4BZnAPBY0s2N2iB
 6DB/6LbzufnR3LlGw7lKnmnwzvf2766vIbqmhEqtGzqvjmJj/dabncFVIxRVGP1c1ZI9tMtY2iO
 l03yo+EXS4XowUVk=
X-Received: by 2002:a05:6214:f2e:b0:670:d117:1f9e with SMTP id
 iw14-20020a0562140f2e00b00670d1171f9emr613271qvb.2.1699913734455; 
 Mon, 13 Nov 2023 14:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGHzCL0PRTiMaWYArc9jmx/3b/hkh7B9yLmbEYpKaPXAwOh/iJPg1Psv0nPA0RCIOzyBD/jA==
X-Received: by 2002:a05:6214:f2e:b0:670:d117:1f9e with SMTP id
 iw14-20020a0562140f2e00b00670d1171f9emr613260qvb.2.1699913734235; 
 Mon, 13 Nov 2023 14:15:34 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m1-20020ad44a01000000b00677ad5a91e1sm2253796qvz.53.2023.11.13.14.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 14:15:33 -0800 (PST)
Date: Mon, 13 Nov 2023 17:15:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH v2 1/4] migration/multifd: Stop setting p->ioc before
 connecting
Message-ID: <ZVKgA2OB71TJflDZ@x1n>
References: <20231110200241.20679-1-farosas@suse.de>
 <20231110200241.20679-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231110200241.20679-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Nov 10, 2023 at 05:02:38PM -0300, Fabiano Rosas wrote:
> This is being shadowed but the assignments at
> multifd_channel_connect() and multifd_tls_channel_connect() .
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


