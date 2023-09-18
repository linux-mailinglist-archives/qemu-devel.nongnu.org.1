Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8FE7A4A31
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiDka-0008EY-TD; Mon, 18 Sep 2023 08:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiDkY-0008CP-If
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:53:14 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiDkV-000459-HF
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:53:14 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57128297bd7so2936682eaf.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695041589; x=1695646389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51pvQydMs1QhGwEX+BsytwUIheQ3sUM6aM8YU1l7Uh0=;
 b=kdAhZv+tgjzivQYoav8h0myHTQmlLJhWbM5Uk9u9RL2ubILFjivfEuC/9rzTJdCxu7
 fFT7GItl0wagRyen1o6mgIN27ipjr6q0eoeJdjzUk+jFDMaQxYsZ0ZzS8ufq/YPlFIT/
 ALD1M6FTW/C2NlFYYBOenIKUhFLiYcb4VPwNeJIhm8RGVky6pyuTlOKpnugdfHhU0bpk
 057/+0ZAWpY7Of0RKXvsjQr9jN6tl5xZ06cDX3tqZmoPpEKhFekyv27zaxixZjyjDTHz
 A6l2DowFxG6Qlyig11zMEkyJgQxrw0UEUNtcb6Q8Yx6qn+v9HNi39E/DFIhTQ97M/Twk
 HXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695041589; x=1695646389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51pvQydMs1QhGwEX+BsytwUIheQ3sUM6aM8YU1l7Uh0=;
 b=lqZ+JmXriU63b1CPFM5azA7oKd+yWzqPfZfOnJtbHH29nwUbfTO4cq1UlMWfMvSC4r
 96VgfNeaKAOM5DWOrzupHhx4DGrRIev6WNAYP7/5kTTLeg6nHQz7yZGpteMzIx95J6IO
 YB+eUlc9GkmwjPQ+FISShpWNGo11U9GxNmYLTjNlv87khLqltsgCLwOwb6wsxjKOJgld
 rciZCxSZY+Wun4/oSv99Pp/E2FFoEc8VVOTXLs0Fv5rys0rNKzua1QOlI3zu9eh+GiT9
 U2x3nWV9YetCn7Rslj3Dc9bPt0U1JwJ33r/pREc6nB72GLUvGHw27jtS31HXnYljtlXV
 z4oQ==
X-Gm-Message-State: AOJu0Yyq2gGLvtfqg90suhnBFgOIz8V6h2NPTHljkIUwj1wDDqfV7LlX
 dCRtq2XbLqpC4kbaRsZYwjzHYAW8fgcnGP17AFw=
X-Google-Smtp-Source: AGHT+IGulHxoifRZ2bE1PCysmj3V+KmjoTVjp6ErHSbQ6/oEtrldeInJ4B3p5PlmqFpRkJ41Gr6oPteaMYV1/SdiRLI=
X-Received: by 2002:a4a:2a14:0:b0:576:8bd8:9ab5 with SMTP id
 k20-20020a4a2a14000000b005768bd89ab5mr9431898oof.1.1695041589663; Mon, 18 Sep
 2023 05:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230912105359.563101-1-kraxel@redhat.com>
 <CAJSP0QX23UNOTCRsiHZWSa1j9KGA229S84+k7nNiDyp-AkNCFg@mail.gmail.com>
 <d7zwpgvdosd7ron3odscmwfqq5cwibyqi2drkjv22z5m5nzn3r@ltokhlip4ztv>
In-Reply-To: <d7zwpgvdosd7ron3odscmwfqq5cwibyqi2drkjv22z5m5nzn3r@ltokhlip4ztv>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 18 Sep 2023 08:52:57 -0400
Message-ID: <CAJSP0QU4EocB1FaAwwcUS9aZShXb5nr+ME1LEqe=Gujn39h-Lw@mail.gmail.com>
Subject: Re: [PULL 0/3] Firmware/seabios 20230912 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
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

T24gTW9uLCAxOCBTZXB0IDIwMjMgYXQgMDY6MDAsIEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRo
YXQuY29tPiB3cm90ZToNCj4NCj4gPiBIaSBHZXJkLA0KPiA+IEkgdGhpbmsgZWl0aGVyIHRoaXMg
cHVsbCByZXF1ZXN0IG9yIHlvdXIgZWRrMiBwdWxsIHJlcXVlc3QgY2F1c2VzIHRoZQ0KPiA+IGZv
bGxvd2luZyBDSSBmYWlsdXJlOg0KPiA+DQo+ID4gPj4+IEdfVEVTVF9EQlVTX0RBRU1PTj0vYnVp
bGRzL3FlbXUtcHJvamVjdC9xZW11L3Rlc3RzL2RidXMtdm1zdGF0ZS1kYWVtb24uc2ggUVRFU1Rf
UUVNVV9CSU5BUlk9Li9xZW11LXN5c3RlbS1hYXJjaDY0IE1BTExPQ19QRVJUVVJCXz0xOTkgL2J1
aWxkcy9xZW11LXByb2plY3QvcWVtdS9idWlsZC90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0
IC0tdGFwIC1rDQo+ID4g4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCVIOKcgCDigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJUNCj4NCj4gQWRkcmVzcyBjaGFuZ2UgaW4gQUNQSSB0YWJsZXMgKGVkazIg
UFIpOg0KPg0KPiAgICAgIERlZmluaXRpb25CbG9jayAoIiIsICJTU0RUIiwgMSwgIkJPQ0hTICIs
ICJOVkRJTU0iLCAweDAwMDAwMDAxKQ0KPiAgICAgIHsNCj4gICAgICAgICAgU2NvcGUgKFxfU0Ip
DQo+ICAgICAgICAgIHsNCj4gICAgICAgICAgICAgIERldmljZSAoTlZEUikNCj4gICAgICAgICAg
ICAgIHsNCj4gICAgICAgICAgICAgICAgICBOYW1lIChfSElELCAiQUNQSTAwMTIiIC8qIE5WRElN
TSBSb290IERldmljZSAqLykgIC8vIF9ISUQ6IEhhcmR3YXJlIElEDQo+ICAgICAgICAgICAgICAg
ICAgWyAuLi4gXQ0KPiAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICB9DQo+DQo+ICAgICAtICAg
IE5hbWUgKE1FTUEsIDB4NDNEMTAwMDApDQo+ICAgICArICAgIE5hbWUgKE1FTUEsIDB4NDNDOTAw
MDApDQo+ICAgICAgfQ0KPg0KPiBzZWFiaW9zIFBSIGlzIGZpbmUgYW5kIHBhc3NlcyAibWFrZSBj
aGVjayIuDQoNCkknbSBzdGlsbCBzZWVpbmcgYSBDSSBmYWlsdXJlOg0KDQozLzYxIHFlbXU6cXRl
c3QrcXRlc3QteDg2XzY0IC8gcXRlc3QteDg2XzY0L2Jpb3MtdGFibGVzLXRlc3QgRVJST1INCjE5
LjE4cyBraWxsZWQgYnkgc2lnbmFsIDYgU0lHQUJSVA0K4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVIOKcgCDigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJXi
gJXigJXigJXigJXigJXigJXigJXigJXigJXigJXigJUNCnN0ZGVycjoNCmFjcGktdGVzdDogV2Fy
bmluZyEgRFNEVCBiaW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsDQpbYW1sOi92YXIvZm9sZGVy
cy83Ni96eTVrdGtuczUwdjZndDVnOHIwc2Y2c2MwMDAwZ24vVC9hbWwtU1c3SUIyXSwNCkV4cGVj
dGVkIFthbWw6dGVzdHMvZGF0YS9hY3BpL3EzNS9EU0RULm1taW82NF0uDQpTZWUgc291cmNlIGZp
bGUgdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jIGZvciBpbnN0cnVjdGlvbnMgb24gaG93
DQp0byB1cGRhdGUgZXhwZWN0ZWQgZmlsZXMuDQp0byBzZWUgQVNMIGRpZmYgYmV0d2VlbiBtaXNt
YXRjaGVkIGZpbGVzIGluc3RhbGwgSUFTTCwgcmVidWlsZCBRRU1VDQpmcm9tIHNjcmF0Y2ggYW5k
IHJlLXJ1biB0ZXN0cyB3aXRoIFY9MSBlbnZpcm9ubWVudCB2YXJpYWJsZSBzZXQqKg0KRVJST1I6
Li4vdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOjUzNTp0ZXN0X2FjcGlfYXNsOiBhc3Nl
cnRpb24NCmZhaWxlZDogKGFsbF90YWJsZXNfbWF0Y2gpDQoodGVzdCBwcm9ncmFtIGV4aXRlZCB3
aXRoIHN0YXR1cyBjb2RlIC02KQ0KDQpodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3Fl
bXUvLS9qb2JzLzUxMTA2MDgxMjMNCg0KPg0KPiB0YWtlIGNhcmUsDQo+ICAgR2VyZA0KPg0K

