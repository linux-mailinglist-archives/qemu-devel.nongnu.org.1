Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549D27E7108
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 19:01:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r19K0-0003op-LE; Thu, 09 Nov 2023 13:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r19Jt-0003od-Ad
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:59:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r19Jq-0000lT-MP
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699552793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB36mxktbVBMpiVVO/3+GulQyQf02S1+NrVV5rhh3n8=;
 b=iQ9di8Jx0qJoSba6e+h+m9UeihbGF7R2V8GZpNZ3oM6KDMwrncqzSg3kq2Sch4mYKPjhrW
 lxndJDdnIgqJvLJ6SVVcjEOPwc1yKKtknXlmGQybKMty9S6cxj6MRfV/9aeVDiWQL+MeGb
 8smnlGGhLevITSTG2Ahk8bLBmSztI+E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-teNr6bMINUeQF9PLYVFRLg-1; Thu, 09 Nov 2023 12:59:52 -0500
X-MC-Unique: teNr6bMINUeQF9PLYVFRLg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41b83b8dbe1so14460541cf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699552792; x=1700157592;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eB36mxktbVBMpiVVO/3+GulQyQf02S1+NrVV5rhh3n8=;
 b=aYlRkuUkohUIyGlijs7M9gBsBD7fvpUNDaAdICm7g/NF+Jz75/wB1F4MmMRzXeSw1B
 Jq3tDmvI0WgQr+1ssGRgDrroT7N4E3v+BKFhLaIJGAzreZHWwMs5bKDEKsTHfP5SFsaT
 X9/tkhN925uGGgtlL2RpBHSJJLr6uE6FzW6wqnLHSZCDpJdNG1pwW3tSWFjr4qPOPjcF
 6EfNENo55+lWK5RPNBoxSbRC1JV93ZXROUpdOFyzmyQ5n79jz3r0ta+u6eO0gX5zt7vj
 dflw7LcJao8usAJ22YBkCgz2l3zCZcOosHkkXgeiyTlzj63vnljrIZczXAtkT7B9DjQZ
 qOWw==
X-Gm-Message-State: AOJu0YwYgGH/pzDXykHyU2/3677X2IcCKTU78/kQe9YVhyqMD5XsWE8i
 eUPwklJvUHQGy1ZlpgsQexm+sTSeu/XJXTTaqNGQbW+gvZX4J8QwJZtLPsL7lN3/dGlyjsuJ/1z
 g3dsiDK+gnGscI1fqbLWES/2ZsRk4xTY=
X-Received: by 2002:ac8:4e8e:0:b0:419:50c7:f6bc with SMTP id
 14-20020ac84e8e000000b0041950c7f6bcmr6081755qtp.22.1699552791848; 
 Thu, 09 Nov 2023 09:59:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBs4fpW9GW5QrjfzEFGuvoCAIoHp0Usgjx+ofl7PqOK50rdcRa+AIQ2KbonENP1WC35GPWJ/7Y/FX7sTBYrXM=
X-Received: by 2002:ac8:4e8e:0:b0:419:50c7:f6bc with SMTP id
 14-20020ac84e8e000000b0041950c7f6bcmr6081742qtp.22.1699552791638; Thu, 09 Nov
 2023 09:59:51 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Nov 2023 09:59:50 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-9-victortoso@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231016152704.221611-9-victortoso@redhat.com>
Date: Thu, 9 Nov 2023 09:59:50 -0800
Message-ID: <CABJz62PJHOY8CLNe-xOrDqRupWMxVCz08WvaxY7tfg8e2WwOpg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] qapi: golang: Generate qapi's event types in Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_LITECOIN_ID=0.5, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Oct 16, 2023 at 05:27:01PM +0200, Victor Toso wrote:
> This patch handles QAPI event types and generates data structures in
> Go that handles it.
>
> We also define a Event interface and two helper functions MarshalEvent
> and UnmarshalEvent.
>
> Example:
> qapi:
>  | { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
>  |   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }
>
> go:
>  | type MemoryDeviceSizeChangeEvent struct {
>  |         MessageTimestamp Timestamp `json:"-"`
>  |         Id               *string   `json:"id,omitempty"`
>  |         Size             uint64    `json:"size"`
>  |         QomPath          string    `json:"qom-path"`
>  | }
>
> usage:
>  | input := `{"event":"MEMORY_DEVICE_SIZE_CHANGE",` +
>  | `"timestamp":{"seconds":1588168529,"microseconds":201316},` +
>  | `"data":{"id":"vm0","size":1073741824,"qom-path":"/machine/unattached/device[2]"}}`
>  | e, err := UnmarshalEvent([]byte(input)
>  | if err != nil {
>  |     panic(err)
>  | }
>  | if e.GetName() == `MEMORY_DEVICE_SIZE_CHANGE` {
>  |     m := e.(*MemoryDeviceSizeChangeEvent)
>  |     // m.QomPath == "/machine/unattached/device[2]"
>  | }

I don't think we should encourage people to perform string
comparisons, as it completely sidesteps Go's type system and is thus
error-prone. Safer version:

  switch m := e.(type) {
  case *MemoryDeviceSizeChangeEvent:
    // m.QomPath == "/machine/unattached/device[2]"
  }

Now, I'm not sure I would go as far as suggesting that the GetName()
function should be completely removed, but maybe we can try leaving
it out from the initial version and see if people start screaming?

API-wise, I'm not a fan of the fact that we're forcing users to call
(Un)MarshalEvent instead of the standard (Un)MarshalJSON. If we add
something like

  func GetEventType(data []byte) (Event, error) {
    type event struct {
      Name string `json:"event"`
    }

    tmp := event{}
    if err := json.Unmarshal(data, &tmp); err != nil {
      return nil, err
    }

    switch tmp.Name {
    case "MEMORY_DEVICE_SIZE_CHANGE":
            return &MemoryDeviceSizeChangeEvent{}, nil
    ...
    }

    return nil, fmt.Errorf("unrecognized event '%s'", tmp.Name)
  }

it becomes feasible to stick with standard functions. We can of
course keep the (Un)MarshalEvent functions around for convenience,
but I don't think they should be the only available API.

-- 
Andrea Bolognani / Red Hat / Virtualization


