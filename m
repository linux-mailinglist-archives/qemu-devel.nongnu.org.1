Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02E783640
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 01:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYEKU-0007Fd-Ct; Mon, 21 Aug 2023 19:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qYEKR-0007FH-8z
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 19:28:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qYEKP-0002o3-24
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 19:28:59 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdbbede5d4so30280575ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692660534; x=1693265334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0GIIQ8yC2eCQt8H9S1hgKT+umlJFOrBWBELG5SVs51g=;
 b=ZMt0mEVN95kO57cG9avlcHac3+5xzWaHbp0SjGcZFM3+F4nns7/B/IerMaQ4od0QHu
 LIQpccGU6ZsKO445s5KTeHAjDc6Tp7iitdlQbkLHV3lkDUN5/sX/KyxXG+mh6ONNWHXp
 3HIdJLTaEQyR8inCml4Oom+u68CZ5wu5NO3u6UHhgLz4JSAD6uOMQWrCYSeBQ2924PCh
 LKLi8fF3LUv7t0k/SlrgRv/2UfAv5yDo3iu8q1/m3US1txnlAYcgQRLbmj/JwhdTviWt
 U8Pd4+6EWDcqfNhBBpMQ0zx//oxkENDMNo7GaM0Blh3yaV4vIFTIlo5e1RaDj2Kzcr8k
 NZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692660534; x=1693265334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0GIIQ8yC2eCQt8H9S1hgKT+umlJFOrBWBELG5SVs51g=;
 b=ARMD8Tcdi1YVNcOp8cwQgltDGci40DtTXCplf6YoFI9onsaBTwTjInJjbElMw99UXc
 mGKN7BS6an1ZMz79bV2r/8P6JZJ+PTVVeIoyCBbAjahUPlg7EwQVHvdcVtpyf8e2p5Cu
 C19m3+eWZPXP8rc5nspJLVWXauu36pLa2DqnQ6tS+HfzqxgU5bQURIUsqrdi8djQq8SK
 ud7jlyj6oEWdC7lhYtYJB0hUnzt982JMwSi8Q5bbjIfW7A8NeIOVrrkiPhrEoc/FscfT
 uXguIYp0k1Gft/22nsWjCeIjSkDlpwvf51FZBl5WjeLL+diPZALAIBinuXMirVh2WKa/
 XgTw==
X-Gm-Message-State: AOJu0YxUXhcuhctR8yEpT/UfXkcuXFE/hNgTGaZsFEZc6602gkupuPTj
 9a5rNYWtmBVDPqFMCTGl6V4=
X-Google-Smtp-Source: AGHT+IEm+XVmoxn/BJwXRXpEsa4bbuU4jtR3+ln2ikN92psace5xnAEU/6WPclXMbx90UNfsusnCUA==
X-Received: by 2002:a17:902:e5cd:b0:1b0:f8:9b2d with SMTP id
 u13-20020a170902e5cd00b001b000f89b2dmr8733682plf.29.1692660534595; 
 Mon, 21 Aug 2023 16:28:54 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 u9-20020a170902e5c900b001bba3a4888bsm7590514plf.102.2023.08.21.16.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 16:28:53 -0700 (PDT)
Date: Mon, 21 Aug 2023 16:28:52 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 19/58] qom: implement property helper for sha384
Message-ID: <20230821232852.GC3642077@ls.amr.corp.intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-20-xiaoyao.li@intel.com>
 <ZOMtj0La71zf/uGd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOMtj0La71zf/uGd@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 21, 2023 at 10:25:35AM +0100,
"Daniel P. Berrangé" <berrange@redhat.com> wrote:

> On Fri, Aug 18, 2023 at 05:50:02AM -0400, Xiaoyao Li wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > Implement property_add_sha384() which converts hex string <-> uint8_t[48]
> > It will be used for TDX which uses sha384 for measurement.
> 
> I think it is likely a better idea to use base64 for the encoding
> the binary hash - we use base64 for all the sev-guest properties
> that were binary data.
> 
> At which points the property set/get logic is much simpler as it
> is just needing a call to  g_base64_encode / g_base64_decode and
> length validation for the decode case.

Hex string is poplar to show hash value, isn't it?  Anyway it's easy for human
operator, shell scripts, libvirt or whatever to convert those representations
with utility commands like base64 or xxd, or library call.  Either way would
work.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

