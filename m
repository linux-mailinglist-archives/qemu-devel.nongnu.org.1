Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA047E28A5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:28:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01WZ-0002mk-DJ; Mon, 06 Nov 2023 10:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r01WX-0002mQ-OH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r01WW-0003Ds-3E
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699284498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jj5rjVbhExKuG/ag9YigwyelVThIKOIH76ffjDMd0uw=;
 b=cFsUpygsDKRIqGIJLJmNRzVksBUWSJPVGaaujRJ5iWcz4rehgggTVxF8wuB3uQ/dsdv4y2
 OXpX+LWdERYAkfzJxrWGxmUJZYsbg3M8TjPqocDqMFS3HerIEklQrk7rmo5erkKmmTn7p6
 5H83YG6ereHmZd8k6+6et8f2lrtayyQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-3GmcFyriP3K-6OrW5rgfbw-1; Mon, 06 Nov 2023 10:28:06 -0500
X-MC-Unique: 3GmcFyriP3K-6OrW5rgfbw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6ce270bc429so5841768a34.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284486; x=1699889286;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jj5rjVbhExKuG/ag9YigwyelVThIKOIH76ffjDMd0uw=;
 b=RPOQvswH42wjYbqu17N6Ia60xs76oA8Ao5fC1PNVIUfX4YFk/EoSHN7O/YP40ucty7
 iHkCh8AkbbdQfVgYP4UNIa36Ptmug+YiNlYClP9vmOTxWTvIVw1EtNIljF8DupbLM0xe
 O8m+cDHCdgMBz9NA0fyVcatN+v2OBA4pM38bK2lCH1shHKsOG+4EfwmiPAOQ9h2F+JD9
 aErtduyAeMEIGaJj/QSWssnFkUWp/8Sbh4Eate+Pz7D3MD9y6EEq6fP8TSA/3IOKmg7e
 i81nLyBnOaTyIG8xzppHL36MQPGqlyInkjuHNaABp46xC9QR+kMjeE9SE08lt4LNQuRO
 ffzw==
X-Gm-Message-State: AOJu0YzyR1jeyOQLFN9m6+PNKUWOf4F6EpT+H6DcIxod6EGyjUC8/evY
 glTISaB/Z+WaZdmoNRHdPutuNFIDyjDRDi02G+sHEJfRQv3Wy1cqajWiAsq4/rCEXFrt/H+nXx+
 bwlN5merz/t9tEQlGDDPV/OPPoECFdsQ=
X-Received: by 2002:a05:6830:10f:b0:6b7:4a86:f038 with SMTP id
 i15-20020a056830010f00b006b74a86f038mr29424505otp.15.1699284486048; 
 Mon, 06 Nov 2023 07:28:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfR/XlYD6NjsgSEmsNhDI6m6HvZvtqVEaYjDJAqwmlKyZhFMGrHAs9kNMKyh9OsgjzR+H4QtQP/21wl4axnsI=
X-Received: by 2002:a05:6830:10f:b0:6b7:4a86:f038 with SMTP id
 i15-20020a056830010f00b006b74a86f038mr29424489otp.15.1699284485758; Mon, 06
 Nov 2023 07:28:05 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 07:28:04 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-5-victortoso@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231016152704.221611-5-victortoso@redhat.com>
Date: Mon, 6 Nov 2023 07:28:04 -0800
Message-ID: <CABJz62O9YKuRHqW2_WUijzY5PfqmjxDjbU=7-O4cp0OO+JQi3g@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] qapi: golang: Generate qapi's alternate types in
 Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 16, 2023 at 05:26:57PM +0200, Victor Toso wrote:
> This patch handles QAPI alternate types and generates data structures
> in Go that handles it.
>
> Alternate types are similar to Union but without a discriminator that
> can be used to identify the underlying value on the wire. It is needed
> to infer it. In Go, most of the types [*] are mapped as optional
> fields and Marshal and Unmarshal methods will be handling the data
> checks.
>
> Example:
>
> qapi:
>   | { 'alternate': 'BlockdevRef',
>   |   'data': { 'definition': 'BlockdevOptions',
>   |             'reference': 'str' } }
>
> go:
>   | type BlockdevRef struct {
>   |         Definition *BlockdevOptions
>   |         Reference  *string
>   | }
>
> usage:
>   | input := `{"driver":"qcow2","data-file":"/some/place/my-image"}`
>   | k := BlockdevRef{}
>   | err := json.Unmarshal([]byte(input), &k)
>   | if err != nil {
>   |     panic(err)
>   | }
>   | // *k.Definition.Qcow2.DataFile.Reference == "/some/place/my-image"
>
> [*] The exception for optional fields as default is to Types that can
> accept JSON Null as a value. For this case, we translate NULL to a
> member type called IsNull, which is boolean in Go.  This will be
> explained better in the documentation patch of this series but the
> main rationale is around Marshaling to and from JSON and Go data
> structures.

These usage examples are great; in fact, I think they're too good to
be relegated to the commit messages. I would like to see them in the
actual documentation.

At the same time, the current documentation seems to focus a lot on
internals rather than usage. I think we really need two documents
here:

  * one for users of the library, with lots of usage examples
    (ideally at least one for JSON->Go and one for Go->JSON for each
    class of QAPI object) and little-to-no peeking behind the
    curtains;

  * one for QEMU developers / QAPI maintainers, which goes into
    detail regarding the internals and explains the various design
    choices and trade-offs.

Some parts of the latter should probably be code comments instead. A
reasonable balance will have to be found.

> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> +TEMPLATE_HELPER = """
> +// Creates a decoder that errors on unknown Fields
> +// Returns nil if successfully decoded @from payload to @into type
> +// Returns error if failed to decode @from payload to @into type
> +func StrictDecode(into interface{}, from []byte) error {
> +\tdec := json.NewDecoder(strings.NewReader(string(from)))
> +\tdec.DisallowUnknownFields()
> +
> +\tif err := dec.Decode(into); err != nil {
> +\t\treturn err
> +\t}
> +\treturn nil
> +}
> +"""

I think the use of \t here makes things a lot less readable. Can't
you just do

  TEMPLATE_HELPER = """
  func StrictDecode() {
      dec := ...
      if err := ... {
         return err
      }
      return nil
  }
  """

I would actually recommend the use of textwrap.dedent() to make
things less awkward:

  TEMPLATE_HELPER = textwrap.dedent("""
      func StrictDecode() {
          dec := ...
          if err := ... {
             return err
          }
          return nil
      }
  """

This is particularly useful for blocks of Go code that are not
declared at the top level...

> +        unmarshal_check_fields = f"""
> +\t// Check for json-null first
> +\tif string(data) == "null" {{
> +\t\treturn errors.New(`null not supported for {name}`)
> +\t}}"""

... such as this one, which could be turned into:

  unmarshal_check_fields = textwrap.dedent(f"""
      // Check for json-null first
      if string(data) == "null" {{
          return errors.New(`null not supported for {name}`)
      }}
  """)

Much more manageable, don't you think? :)


On a partially related note: while I haven't yet looked closely at
how much effort you've dedicated to producing pretty output, from a
quick look at generate_struct_type() it seems that the answer is "not
zero". I think it would be fine to simplify things there and produce
ugly output, under the assumption that gofmt will be called on the
generated code immediately afterwards. The C generator doesn't have
this luxury, but we should take advantage of it.

-- 
Andrea Bolognani / Red Hat / Virtualization


